require "CSV"
require_relative "./games"
require_relative "./teams"
require_relative "./game_teams"
require_relative "./games_statistics"
require_relative "./season_statistics"
require_relative "./league_statistics"
require_relative "./team_statistics"

class CSVData
 attr_reader  :games, :teams, :game_teams, :league_statistics, :team_statistics, :season_statistics, :games_statistics

 def initialize(locations)
   @games ||= turn_games_csv_data_into_games_objects(locations[:games])
   @teams ||= turn_teams_csv_data_into_teams_objects(locations[:teams])
   @game_teams ||= turn_game_teams_csv_data_into_game_teams_objects(locations[:game_teams])
   @games_statistics = GamesStatistics.new(@games, @teams, @game_teams)
   @season_statistics = SeasonStatistics.new(@games, @teams, @game_teams)
   @league_statistics = LeagueStatistics.new(@games, @teams, @game_teams)
   @team_statistics = TeamStatistics.new(@games, @teams, @game_teams)
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

end
