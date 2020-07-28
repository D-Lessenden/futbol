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

  #  lowest_total_score. Integer
  # percentage_home_wins. Float
  # percentage_visitor_wins. Float
  # percentage_ties. Float
  # count_of_games_by_season. Hash
  # average_goals_per_game. Float
  # average_goals_by_season. Hash
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

