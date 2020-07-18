require "minitest/autorun"
require "minitest/pride"
require "mocha/minitest"
require "./lib/stat_tracker"
require "./lib/games"

class GamesTest < Minitest::Test

  def test_it_exists
    stat_tracker = StatTracker.new(locations)
    @games_csv = stat_tracker.from_csv
    games = Games.new(csv_file)
    assert_instance_of Games, games
  end

  #def test_it_has_attributes
  #end

end
