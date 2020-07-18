require "minitest/autorun"
require "minitest/pride"
require "mocha/minitest"
require "./lib/stat_tracker"
require "./lib/games"
require "CSV"

class GamesTest < Minitest::Test

  def test_it_exists
    games_location = './data/games.csv'

    games = Games.new(games_location)
    assert_instance_of Games, games
  end

  def test_it_can_read_csv_doc
    games_location = './data/games.csv'
    games = Games.new(games_location)
    games.from_csv

  end

  # def test_it_has_attributes
  #   # assert_equal 2012030221, games.game_id
  #   # assert_equal 20122013, games.season
  #
  # end

end
