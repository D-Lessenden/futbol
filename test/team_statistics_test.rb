require "minitest/autorun"
require "minitest/pride"
require "mocha/minitest"
require "./lib/stat_tracker"
require "./lib/team_statistics"

class TeamStatisticsTest < Minitest::Test
  def setup
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }
    @stat_tracker = StatTracker.new(locations)
    @team_statistics = TeamStatistics.new
  end
  def test_it_exists
    assert_instance_of TeamStatistics, @team_statistics
  end

  #def test_it_has_attributes
  #end

end
