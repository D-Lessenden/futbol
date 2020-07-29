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
    stat_tracker = StatTracker.from_csv(locations)
    csv_data = CSVData.new(locations)
    @games_statistics = csv_data.games_statistics
  end

  def test_it_exists
    assert_instance_of GamesStatistics, @games_statistics
  end

  def test_it_can_find_highest_total_score
    assert_equal 11, @games_statistics.highest_total_score
  end

  def test_it_can_calculate_the_lowest_total_score
    assert_equal 0, @games_statistics.lowest_total_score
  end

  def test_it_can_find_percentage_home_wins
    assert_equal 0.44, @games_statistics.percentage_home_wins
  end

  def test_it_can_find_percentage_visitor_wins
    assert_equal 0.36, @games_statistics.percentage_visitor_wins
  end

  def test_can_find_percentage_ties
    assert_equal 0.20, @games_statistics.percentage_ties
  end

  def test_count_games_by_season
    expected = {"20122013" => 806,
                "20162017" => 1317,
                "20142015" => 1319,
                "20152016" => 1321,
                "20132014" => 1323,
                "20172018" => 1355
                }
    assert_equal expected, @games_statistics.count_of_games_by_season
  end

  def test_average_goals_per_game
    assert_equal 4.22, @games_statistics.average_goals_per_game
  end

  def test_average_goals_by_season
    expected = {"20122013" => 4.12, "20162017" => 4.23, "20142015" => 4.14, "20152016" => 4.16, "20132014" => 4.19, "20172018" => 4.44 }
    assert_equal expected, @games_statistics.average_goals_by_season
  end

end 