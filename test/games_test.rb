require "./test/test_helper"

class GamesTest < Minitest::Test

  def setup
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'
    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }
    @stat_tracker = StatTracker.from_csv(locations)
    @csv_data = CSVData.new(locations)
    @games = @csv_data.games
  end

  def test_it_exists
    assert_instance_of Games, @games[0]
  end

  def test_it_has_attributes
      assert_equal "2012030221", @games[0].game_id
      assert_equal "20122013", @games[0].season
      assert_equal "Postseason", @games[0].type
      assert_equal "5/16/13", @games[0].date_time
      assert_equal "3", @games[0].away_team_id
      assert_equal "6", @games[0].home_team_id
      assert_equal 2, @games[0].away_goals
      assert_equal 3, @games[0].home_goals
      assert_equal "Toyota Stadium", @games[0].venue
      assert_equal "/api/v1/venues/null", @games[0].venue_link
    end
  end
