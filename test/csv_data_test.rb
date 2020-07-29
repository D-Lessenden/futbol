require "minitest/autorun"
require "minitest/pride"
require "mocha/minitest"
require "./lib/stat_tracker"
require "./lib/csv_data"

class CSVDataTest < Minitest::Test

  def test_it_exists
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }
    StatTracker.from_csv(locations)
    csv_data = CSVData.new(locations)
    assert_instance_of CSVData, csv_data
  end

  #def test_it_has_attributes
  #end

end
