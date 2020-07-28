require "./test/test_helper"

class LeagueStatisticsTest < MiniTest::Test

  def setup
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    @league_statistics = LeagueStatistics.new(locations)
  end

  def test_count_of_teams
    assert_equal 32, @league_statistics.count_of_teams
  end
end
