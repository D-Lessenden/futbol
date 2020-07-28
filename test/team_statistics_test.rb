require "minitest/autorun"
require "minitest/pride"
require "mocha/minitest"
require "./lib/stat_tracker"
require "./lib/team_statistics"

class TeamStatisticsTest < Minitest::Test

  def test_it_exists
    team_statistics = TeamStatistics.new
    assert_instance_of TeamStatistics, team_statistics
  end

  #def test_it_has_attributes
  #end

end
