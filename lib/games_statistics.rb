require "CSV"
require_relative "./games"
require_relative "./teams"
require_relative "./game_teams"

class GamesStatistics
  attr_reader :games, :game_teams, :teams
  
  def self.from_csv(locations)
    GamesStatistics.new(locations)
  end

  def initialize(locations)
    @games ||= turn_games_csv_data_into_games_objects(locations[:games])
    @teams ||= turn_teams_csv_data_into_teams_objects(locations[:teams])
    @game_teams ||= turn_game_teams_csv_data_into_game_teams_objects(locations[:game_teams])
  end

  def turn_games_csv_data_into_games_objects(games_csv_data)
    games_objects_collection = []
    CSV.foreach(games_csv_data, headers: true, header_converters: :symbol, row_sep: :auto) do |row|
      games_objects_collection << Games.new(row)
    end
    games_objects_collection
  end

  def turn_teams_csv_data_into_teams_objects(teams_csv_data)
    teams_objects_collection = []
    CSV.foreach(teams_csv_data, headers: true, header_converters: :symbol, row_sep: :auto) do |row|
      teams_objects_collection << Teams.new(row)
    end
    teams_objects_collection
  end

  def turn_game_teams_csv_data_into_game_teams_objects(game_teams_csv_data)
    game_teams_objects_collection = []
    CSV.foreach(game_teams_csv_data, headers: true, header_converters: :symbol, row_sep: :auto) do |row|
      game_teams_objects_collection << GameTeams.new(row)
    end
    game_teams_objects_collection
  end

  ##=============================================

  def highest_total_score
    output = @games.max_by do |game|
      game.away_goals + game.home_goals
    end
    output.away_goals + output.home_goals
  end

  def lowest_total_score
    output = @games.min_by do |game|
      game.away_goals + game.home_goals
    end
    output.away_goals + output.home_goals
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
    total_visitor_wins = @games.select do |game|
      game.away_goals > game.home_goals
    end
    (total_visitor_wins.length.to_f / @games.length).round(2)
  end

  def percentage_ties
    game_ties = @game_teams.select do |game|
      game.result == "TIE"
    end
    (game_ties.count / @game_teams.count.to_f).round(2)
  end

  def count_of_games_by_season
    games_by_season = @games.group_by {|game| game.season}
    game_count_per_season = {}
    games_by_season.map {|season, game| game_count_per_season[season] = game.count}
    game_count_per_season
  end



end