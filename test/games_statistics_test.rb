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

  # highest_total_score.  Integer
  def test_it_can_find_highest_total_score
    assert_equal 11, @games_statistics.highest_total_score
  end

  # lowest_total_score. Integer
  def test_it_can_calculate_the_lowest_total_score
    assert_equal 0, @games_statistics.lowest_total_score
  end

  # percentage_home_wins. Float
  def test_it_can_find_percentage_home_wins
    assert_equal 0.44, @games_statistics.percentage_home_wins
  end

  # percentage_visitor_wins. Float
  def test_it_can_find_percentage_visitor_wins
    assert_equal 0.36, @games_statistics.percentage_visitor_wins
  end

  # percentage_ties. Float
  def test_can_find_percentage_ties
    assert_equal 0.20, @games_statistics.percentage_ties
  end

  # count_of_games_by_season. Hash
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

  # average_goals_per_game. Float
  def test_average_goals_per_game
    assert_equal 4.22, @games_statistics.average_goals_per_game
  end

  # average_goals_by_season. Hash
  def test_average_goals_by_season
    expected = {"20122013" => 4.12, "20162017" => 4.23, "20142015" => 4.14, "20152016" => 4.16, "20132014" => 4.19, "20172018" => 4.44 }
    assert_equal expected, @games_statistics.average_goals_by_season
  end

end 


# Game Statistics
# highest_total_score.  Integer
#  lowest_total_score. Integer
# percentage_home_wins. Float
# percentage_visitor_wins. Float
# percentage_ties. Float
# count_of_games_by_season. Hash
# average_goals_per_game. Float
# average_goals_by_season. Hash

# GW	percentage_home_wins	M	Float	Percentage of games that a home team has won	Game	@game_teams																					
# GW	percentage_visitor_wins	M	Float	Percentage of games that a home team has won	Game	@games																				
# AA	highest_total_score	M	Integer	Highest sum of the winning and losing teams’ scores	Games	@games																					
# AA	lowest_total_score	M	Integer	Lowest sum of the winning and losing teams’ scores	Games	@games																					
# NR	average_goals_by_season	M	Hash	Average number of goals scored in a game organized in a hash with season names (e.g. 20122013) as keys and a float representing the average number of goals in a game for that season as values 	Games	@games																					
# NR	average_goals_per_game	M	Float	Average number of goals scored in a game across all seasons including both home and away goals	Games	@games								

