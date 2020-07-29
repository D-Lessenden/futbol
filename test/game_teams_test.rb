require "./test/test_helper"

class GameTeamsTest < Minitest::Test
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
    @game_teams = @csv_data.game_teams
  end

  def test_it_exists
    assert_instance_of GameTeams, @game_teams[0]
  end

  def test_it_has_attributes

    assert_equal "2012030221", @game_teams[0].game_id
    assert_equal "3", @game_teams[0].team_id
    assert_equal "away", @game_teams[0].hoa
    assert_equal "LOSS", @game_teams[0].result
    assert_equal "OT", @game_teams[0].settled_in
    assert_equal "John Tortorella", @game_teams[0].head_coach
    assert_equal 2, @game_teams[0].goals
    assert_equal 8, @game_teams[0].shots
    assert_equal 44, @game_teams[0].tackles
    assert_equal 8, @game_teams[0].pim
    assert_equal 3, @game_teams[0].powerplayopportunities
    assert_equal 0, @game_teams[0].powerplaygoals
    assert_equal 44.8, @game_teams[0].faceoffwinpercentage
    assert_equal 17, @game_teams[0].giveaways
    assert_equal 7, @game_teams[0].takeaways
  end
end
