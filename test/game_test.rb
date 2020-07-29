require "./lib/csv_data"
require "./test/test_helper"

class GameTest < Minitest::Test

  def setup
      game_path = './data/games.csv'
      team_path = './data/teams.csv'
      game_teams_path = './data/game_teams.csv'

      locations = {
        games: game_path,
        teams: team_path,
        game_teams: game_teams_path
      }
        stat_tracker = StatTracker.new(locations)
        
        @games = Games.new()
  end

  def test_it_exists

    assert_instance_of Games, @games
  end

  def test_it_has_attributes

      assert_equal "2014030412", @games.game_id
      assert_equal "20142015", @games.season
      assert_equal "Postseason", @games.type
      assert_equal "6/6/15", @games.date_time
      assert_equal "16", @games.away_team_id
      assert_equal "14", @games.home_team_id
      assert_equal 3, @games.away_goals
      assert_equal 2, @games.home_goals
      assert_equal "Audi Field", @games.venue
      assert_equal "/api/v1/venues/null", @games.venue_link
    end
  end
