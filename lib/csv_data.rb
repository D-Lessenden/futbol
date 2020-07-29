require "CSV"
require "./lib/games"
require "./lib/teams"
require "./lib/game_teams"
require "./lib/team_statistics"

class CSVData
 attr_reader  :team_statistics
 def initialize(locations)
   @games ||= turn_games_csv_data_into_games_objects(locations[:games])
   @teams ||= turn_teams_csv_data_into_teams_objects(locations[:teams])
   @game_teams ||= turn_game_teams_csv_data_into_game_teams_objects(locations[:game_teams])
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