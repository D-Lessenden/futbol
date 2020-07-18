require "minitest/autorun"
require "minitest/pride"
require "mocha/minitest"
require "./lib/game"

class GameTest < Minitest::Test
# Sample Game - 2014030412,20142015,Postseason,6/6/15,16,14,3,2,Audi Field,/api/v1/venues/null
  def test_it_exists
    info = {
      :game_id => "2014030412",
      :season => "20142015",
      :type => "Postseason",
      :date_time => "6/6/15",
      :away_team_id => "16",
      :home_team_id => "14",
      :away_goals => 3,
      :home_goals => 2,
      :venue => "Audi Field",
      :venue_link => "/api/v1/venues/null"
      }

      game = Game.new(info)

    assert_instance_of Game, game
  end

  def test_it_has_attributes
    info = {
      :game_id => "2014030412",
      :season => "20142015",
      :type => "Postseason",
      :date_time => "6/6/15",
      :away_team_id => "16",
      :home_team_id => "14",
      :away_goals => 3,
      :home_goals => 2,
      :venue => "Audi Field",
      :venue_link => "/api/v1/venues/null"
      }

      game = Game.new(info)

      assert_equal "2014030412", game.game_id
      assert_equal "20142015", game.season
      assert_equal "Postseason", game.type
      assert_equal "6/6/15", game.date_time
      assert_equal "16", game.away_team_id
      assert_equal "14", game.home_team_id
      assert_equal 3, game.away_goals
      assert_equal 2, game.home_goals
      assert_equal "Audi Field", game.venue
      assert_equal "/api/v1/venues/null", game.venue_link
    end
  end
