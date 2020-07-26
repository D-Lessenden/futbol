require "CSV"
require "./lib/games"
require "./lib/teams"
require "./lib/game_teams"
require "./lib/teams"

class StatTracker
  attr_reader :games, :game_teams, :teams

  def self.from_csv(locations)
    StatTracker.new(locations)
  end

  def initialize(locations)
    @games ||= turn_games_csv_data_into_games_objects(locations[:games])
    @teams ||= turn_teams_csv_data_into_teams_objects(locations[:teams])
    @game_teams ||= turn_game_teams_csv_data_into_game_teams_objects(locations[:game_teams])
  end

  def turn_games_csv_data_into_games_objects(games_csv_data)
    games_objects_collection = []
    CSV.foreach(games_csv_data, headers: true, header_converters: :symbol) do |row|
      games_objects_collection << Games.new(row)
    end
    games_objects_collection
  end

  def turn_teams_csv_data_into_teams_objects(teams_csv_data)
    teams_objects_collection = []
    CSV.foreach(teams_csv_data, headers: true, header_converters: :symbol) do |row|
      teams_objects_collection << Teams.new(row)
    end
    teams_objects_collection
  end

  def turn_game_teams_csv_data_into_game_teams_objects(game_teams_csv_data)
    game_teams_objects_collection = []
    CSV.foreach(game_teams_csv_data, headers: true, header_converters: :symbol) do |row|
      game_teams_objects_collection << GameTeams.new(row)
    end
    game_teams_objects_collection
  end

  def percentage_tie
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

  def count_of_teams
    teams.count
  end

  def home_team
    home_team = @games.group_by do |game|
      game.home_team_id
    end
  end

  def goals
    goals = {}
    home_team.each do |team_id, games|
      goal_count = 0
      games.each do |game|
          goal_count += game.home_goals
      end
      average_goals = goal_count / games.count.to_f
      goals[team_id] = average_goals
    end
    goals
  end

  def highest_scoring_home_team
    goals
    id = goals.max_by {|key, value| value}
    @teams.find {|team| team.team_id == id[0]}.teamname
  end

  def lowest_scoring_home_team
    goals
    id = goals.min_by {|team, num_of_goals| num_of_goals}
    @teams.find {|team| team.team_id == id[0]}.teamname
  end

# ###########################

  def season_hash
    season_hash = @games.group_by {|games| games.season}
  end

  def game_ids_by_season
      game_ids_by_season = {}
        season_hash.map do |season, games|
          game_ids_by_season[season] = games.map {|game| game.game_id}
        end
        game_ids_by_season
  end

  def games_by_season
      games_by_season = {}
      game_ids_by_season.map do |season, game_ids|
        season_games = @game_teams.map do |game|
          if game_ids.include?(game.game_id)
            game
          end
        end
        games_by_season[season] = season_games
      end
      games_by_season
  end


  def season_games
    season_games = games_by_season.map {|season, games| games}.flatten.compact
    #array of every single game object
  end


  def team_games_per_season(teamID)
    games_by_team = season_games.select {|team| team.team_id == teamID}
    team_games_per_season = games_by_team.group_by {|game| game.game_id[0..3]}
    #hash organized with season keys and games per season as value
  end

  def best_season(teamID)
    win_hash = Hash.new(0)
    team_games_per_season(teamID).each do |season, games|
      count = 0
      total = 0
      games.each do |game|
          if game.result == "WIN"
            count += 1
            total += 1
          else
            total += 1
          end
      win_hash[season] = [count, total]
        end
      end
  best = win_hash.max_by do |season, games|
    win_hash[season].first / win_hash[season].last.to_f
  end
  math = best[0].to_i
  math += 1
  math.to_s
  answer = best.first + "#{math}"
  end#method

  def worst_season(teamID)
    win_hash = Hash.new(0)
    team_games_per_season(teamID).each do |season, games|
      count = 0
      total = 0
      games.each do |game|
        if game.result == "WIN"
          count += 1
          total += 1
        else
          total += 1
        end
      win_hash[season] = [count, total]
    end
  end
  worst = win_hash.min_by do |season, games|
    win_hash[season].first / win_hash[season].last.to_f
  end
  math = worst[0].to_i
  math += 1
  math.to_s
  worst = worst.first + "#{math}"
  #I know these last 4 lines look odd
  #I needed to convert a 4digit season id to a 8 digit id
  end#method
#####################

def games_per_season_per_team(seasonID)
  games_in_season = @games.select { |game| game.season == seasonID }

    game_ids_in_season = games_in_season.map do |game|
       game.game_id
     end
     game_teams_in_season = @game_teams.select do |game_team|
       game_ids_in_season.include?(game_team.game_id)
     end
     games_per_season_per_team = game_teams_in_season.group_by do |game|
       game.team_id
     end
   end

  def team_tackles(seasonID)
    team_tackles = Hash.new(0)
      games_per_season_per_team(seasonID).each do |team, games|
        games.each do |game|
          team_tackles[game.team_id] += game.tackles
        end
      end
      team_tackles
  end

  def fewest_tackles(seasonID)
    games_per_season_per_team(seasonID)
    team_tackles(seasonID)
    fewest = team_tackles(seasonID).min_by {|k, v| v}
    @teams.find {|team| team.team_id == fewest.first}.teamname
 end#tackle method

 def most_tackles(seasonID)
   games_per_season_per_team(seasonID)
   team_tackles(seasonID)
   most = team_tackles(seasonID).max_by {|k, v| v}
   @teams.find {|team| team.team_id == most.first}.teamname
end#tackle method

 def most_tackles(seasonID)
  games_in_season = @games.select { |game| game.season == seasonID }
  game_ids_in_season = games_in_season.map do |game|
     game.game_id
   end

   game_teams_in_season = @game_teams.select do |game_team|
     game_ids_in_season.include?(game_team.game_id)
   end

   games_per_season_per_team = game_teams_in_season.group_by do |game|
     game.team_id
   end

  team_tackles = Hash.new(0)
    games_per_season_per_team.each do |team, games|
      games.each do |game|
        team_tackles[game.team_id] += game.tackles
      end
    end

  most = team_tackles.max_by {|k, v| v}
  @teams.find {|team| team.team_id == most.first}.teamname
end#tackle method

def fewest_tackles(seasonID)
 games_in_season = @games.select { |game| game.season == seasonID }
 game_ids_in_season = games_in_season.map do |game|
    game.game_id
  end

  game_teams_in_season = @game_teams.select do |game_team|
    game_ids_in_season.include?(game_team.game_id)
  end

  games_per_season_per_team = game_teams_in_season.group_by do |game|
    game.team_id
  end

 team_tackles = Hash.new(0)
   games_per_season_per_team.each do |team, games|
     games.each do |game|
       team_tackles[game.team_id] += game.tackles
     end
   end

 fewest = team_tackles.min_by {|k, v| v}
 @teams.find {|team| team.team_id == fewest.first}.teamname
end#tackle method





end#class
