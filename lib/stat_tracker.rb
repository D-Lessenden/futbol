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
    (home_wins.count / home_games.count.to_f).round(2) ##Nico. Corrected code so it returns .44 as per spec harness instead of .43. Left original code commented below. 
    # total_home_wins = @games.select do |game|
    #   game.home_goals > game.away_goals
    # end
    # (total_home_wins.length.to_f / @games.length).round(2)
  end

  def average_goals_per_game
    games_count = @games.count.to_f
    sum_of_goals = (@games.map {|game| game.home_goals + game.away_goals}.to_a).sum ##Nico. Added game.home_goals + game.away_goals so test passes after we moved helper method from games.rb.

    sum_of_goals_divided_by_game_count = (sum_of_goals / games_count).round(2)
    sum_of_goals_divided_by_game_count
  end
  

  def average_goals_by_season
    games_by_season = @games.group_by {|game| game.season} ##hash of games by season
    games_by_season.delete_if { |key, value| key.nil? || value.nil? } 

    goals_per_season = {} ##hash of total goals by season
    games_by_season.map do |season, games| 
      goals_per_season[season] = games.sum do |game| 
        game.away_goals + game.home_goals
      end
    end 

    avg_goals_per_season = {}
    goals_per_season.each do |season, goals| 
      division = (goals.to_f / count_of_games_by_season[season] ).round(2)
      avg_goals_per_season[season] = division
    end

    avg_goals_per_season

  end

  def percentage_visitor_wins
    total_visitor_wins = @games.select do |game|
      game.away_goals > game.home_goals
    end
    (total_visitor_wins.length.to_f / @games.length).round(2)
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
  game_count_per_season.delete_if { |key, value| key.nil? || value.nil? } ## Nico. Added line here to remove nil ouput. Now passes test.
  end

  def lowest_scoring_home_team
    home_team = @games.group_by do |game|
      game.home_team_id
    end
    goals = {}
    home_team.each do |team_id, games|
      goal_count = 0
      games.each do |game|
          goal_count += game.home_goals
      end
    average_goals = goal_count / games.count.to_f
    goals[team_id] = average_goals
    end
      goals.delete_if { |key, value| key.nil? || value.nil? } ## Nico. Added line here to remove nil ouput. Now passes test.It passes in Daniel's without delete_if. Question for Tim.
      id = goals.min_by {|team, num_of_goals| num_of_goals}
      @teams.find {|team| team.team_id == id[0]}.teamname
  end
  
  def winningest_coach(season) 
    ### Name of the Coach with the best win percentage for the season
    ## 1 - from games class create a hash with a season => games pair
    ## 2 - From games_by_season create a hash with season => game_id pairs so we can use it to talk to game_teams class.
    ## 3 - Using #2 and game_teams. Create a hash with coach games per season (games_per_season_by_coach = {"Season" => {"coach name" => [game instances...]}})
    ## 3.5 create a hash with coach name => total games-results per season (results_by_coach = {"coach name" => {win: 100, loss: 200, tie: 2}})
    ## 4 - Extract sum of all games and percentage of wins.
    ## 5 - find Name of Coach with highest percentage
      
    
    #1
    games_by_season = @games.group_by {|game| game.season}.delete_if { |key, value| key.nil? || value.nil? }

    #2
    game_ids_by_season = {}
    games_by_season.map do |season, games|
      x = games.map {|game| game.game_id}
      game_ids_by_season[season] = x
    end
    game_ids_by_season["20122013"]

    #3
    team_games_by_season = {}
    game_ids_by_season.map do |season, game_ids|
      season_games = @game_teams.map do |game|
        if game_ids.include?(game.game_id)
          game
        end
      end
      team_games_by_season[season] = season_games
    end

    # 3.25
    ## games_per_season_by_coach = {"coach name" => [game instances...]}
    season_games = team_games_by_season.map {|season, games| games}.flatten.compact

    games_per_season_by_coach = season_games.group_by do |game| 
      unless game == nil
        game.head_coach
      end
    end

    #3.5 create a hash with coach name => total games-results per season (results_by_coach = {"coach name" => {win: 100, loss: 200, tie: 2}})

    

    coach_name_and_results = {}

    games_per_season_by_coach.map do |coach, games|
      results_by_coach = {win: 0, loss: 0, tie: 0}
      games.map do |game|
        if game.result == "WIN"
          results_by_coach[:win] = results_by_coach[:win] += 1
        elsif game.result == "LOSS"
          results_by_coach[:loss] = results_by_coach[:loss] += 1
        elsif game.result == "TIE"
            results_by_coach[:tie] = results_by_coach[:tie] += 1
        end
      coach_name_and_results[coach] = results_by_coach
      end
    end
    binding.pry
    # 

    ## 4 - Extract sum of all games and percentage of wins.

    
  end


end












# def best_offense
#   team_by_id = @game_teams.group_by do |team|
#     team.team_id
#   end
#   total_games_by_id = {}
#   team_by_id.map { |id, games| total_games_by_id[id] = games.length}
#   total_goals_by_id = {}
#   team_by_id.map { |id, games| total_goals_by_id[id] = games.sum {|game| game.goals}}
#   average_goals_all_seasons_by_id = {}
#   total_goals_by_id.each do |id, goals|
#     average_goals_all_seasons_by_id[id] = (goals.to_f / total_games_by_id[id] ).round(2)
#   end
#   highest = average_goals_all_seasons_by_id.max_by {|id, avg| avg}
#   best_offense = @teams.find {|team| team.teamname if team.team_id == highest[0]}.teamname
#   best_offense
# end
# def worst_offense
#   team_by_id = @game_teams.group_by do |team|
#     team.team_id
#   end
#   total_games_by_id = {}
#   team_by_id.map { |id, games| total_games_by_id[id] = games.length}
#   total_goals_by_id = {}
#   team_by_id.map { |id, games| total_goals_by_id[id] = games.sum {|game| game.goals}}
#   average_goals_all_seasons_by_id = {}
#   total_goals_by_id.each do |id, goals|
#     average_goals_all_seasons_by_id[id] = (goals.to_f / total_games_by_id[id] ).round(2)
#   end
#   lowest = average_goals_all_seasons_by_id.min_by {|id, avg| avg}
#   worst_offense = @teams.find {|team| team.teamname if team.team_id == lowest[0]}.teamname
#   worst_offense
# end