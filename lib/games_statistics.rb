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
##============================================================
  def highest_scoring_home_team
    id = goals.max_by {|key, value| value}
      @teams.find {|team| team.team_id == id[0]}.teamname
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

  def home_team
    home_team = @games.group_by do |game|
      game.home_team_id
    end
  end
end