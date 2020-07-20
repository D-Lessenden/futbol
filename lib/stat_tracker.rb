require "CSV"
require_relative "./games"
require_relative "./game_teams"

class StatTracker
  attr_reader :games, :game_teams

  def self.from_csv(locations)
    StatTracker.new(locations)
  end

  def initialize(locations)
    @games ||= turn_games_csv_data_into_games_objects(locations[:games])
    @game_teams ||= turn_games_csv_data_into_game_teams_objects(locations[:game_teams])
    # @teams = locations[:teams]
    # @game_teams = locations[:game_teams]
  end

  def turn_games_csv_data_into_games_objects(games_csv_data)
    games_objects_collection = []
    CSV.foreach(games_csv_data, headers: true, header_converters: :symbol) do |row|
      games_objects_collection << Games.new(row)
    end
    games_objects_collection
    # require "pry"; binding.pry
  end

  def turn_games_csv_data_into_game_teams_objects(game_teams_csv_data)
    game_teams_objects_collection = []
    CSV.foreach(game_teams_csv_data, headers: true, header_converters: :symbol) do |row|
      game_teams_objects_collection << GameTeams.new(row)
    end
    game_teams_objects_collection
  end

  def highest_total_score
    output = @games.max_by do |game|
      game.total_game_score
    end
    output.total_game_score
  end

  def lowest_total_score
    output = @games.min_by do |game|
      game.total_game_score
    end
    output.total_game_score
  end

  def percentage_home_wins
    home_games = @game_teams.select do |game| 
      game.hoa == "home"
    end
    home_wins = @game_teams.select do |game| 
      game.result == "WIN" && game.hoa == "home"
    end
    (home_wins.count / home_games.count.to_f).round(2)
  end

  def percentage_visitor_wins
    visitor_games = @game_teams.select do |game| 
      game.hoa == "away"
    end
    visitor_wins = @game_teams.select do |game| 
      game.result == "WIN" && game.hoa == "away"
    end
    (visitor_wins.count / visitor_games.count.to_f).round(2)
  end

  def percentage_ties
    game_ties = @game_teams.select do |game|
      game.result == "TIE"
    end
   (game_ties.count / total_games.to_f).round(2)
  end

  def total_games 
    games = []
    @game_teams.map do |game|
      games << game.result
    end
    games.count 
  end

  def count_of_games_by_season
        
    games_by_season = @games.group_by {|game| game.season}

    game_count_per_season = {}
    games_by_season.map {|season, game| game_count_per_season[season] = game.count}
    
    game_count_per_season
  end

end
