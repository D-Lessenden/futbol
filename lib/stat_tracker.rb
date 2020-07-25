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

end#class
