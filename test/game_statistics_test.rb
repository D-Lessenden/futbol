require "./test/test_helper"


class GameStatisticsTest < MiniTest::Test

  def setup
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    @game_statistics = GameStatistics.from_csv(locations)
  end

  def test_it_exist
    assert_instance_of GameStatistics, @game_statistics
  end

end 