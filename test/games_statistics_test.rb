require "./test/test_helper"


class GamesStatisticsTest < MiniTest::Test

  def setup
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    @games_statistics = GamesStatistics.from_csv(locations)
  end

  def test_it_exists
    assert_instance_of GamesStatistics, @games_statistics
  end

end 