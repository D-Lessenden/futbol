require './test/test_helper'
require "./lib/stat_tracker"
require "./lib/games"
require "./lib/game_teams"

require "pry"

class GameTeamsTest < MiniTest::Test 
  
  def setup
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }
    @gt = GameTeams.new(locations)
  end 
  def test_it_exists

    assert_instance_of GameTeams, @gt
  end


end