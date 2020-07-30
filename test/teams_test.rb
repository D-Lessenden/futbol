require "./test/test_helper"


class TeamsTest < MiniTest::Test
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
    @teams = @csv_data.teams
  end

  def test_it_exists
    assert_instance_of Teams, @teams[0]
  end

  def test_it_has_attributes
    assert_equal "1", @teams[0].team_id
    assert_equal "23", @teams[0].franchiseid
    assert_equal "Atlanta United", @teams[0].teamname
    assert_equal "ATL", @teams[0].abbreviation
    assert_equal "Mercedes-Benz Stadium", @teams[0].stadium
    assert_equal "/api/v1/teams/1", @teams[0].link
  end


end