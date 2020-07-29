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

    @stat_tracker = StatTracker.from_csv(locations)
    @csv_data = CSVData.new(locations)
    @league_statistics = @csv_data.league_statistics

  end

  def test_it_exists
    assert_instance_of LeagueStatistics, @league_statistics
  end

  def test_count_of_teams
    assert_equal 32, @league_statistics.count_of_teams
  end

  def test_it_can_return_best_offense
    assert_equal "Reign FC", @league_statistics.best_offense
  end

  def test_it_can_return_worst_offense
    assert_equal "Utah Royals FC", @league_statistics.worst_offense
  end

  def test_it_can_calculate_highest_scoring_visitor
    assert_equal "FC Dallas", @league_statistics.highest_scoring_visitor
  end

  def test_highest_scoring_home_team
    assert_equal "Reign FC", @league_statistics.highest_scoring_home_team
  end

  def test_it_can_find_lowest_scoring_visitor
    assert_equal "San Jose Earthquakes", @league_statistics.lowest_scoring_visitor
  end

  def test_lowest_scoring_home_team
    assert_equal "Utah Royals FC" ,@league_statistics.lowest_scoring_home_team
  end

  def test_it_can_create_hash_with_total_games_played_by_away_team
    assert_equal 32, @league_statistics.away_teams_game_count_by_team_id.count
    assert_equal Hash, @league_statistics.away_teams_game_count_by_team_id.class
    assert_equal 266, @league_statistics.away_teams_game_count_by_team_id["3"]
    assert_nil @league_statistics.away_teams_game_count_by_team_id["56"]
  end

  def test_it_can_find_highest_total_goals_by_away_team
    assert_equal String, @league_statistics.highest_total_goals_by_away_team[0].class
    assert_equal Integer, @league_statistics.highest_total_goals_by_away_team[1].class
    assert_equal 2, @league_statistics.highest_total_goals_by_away_team.count
    assert_equal Array, @league_statistics.highest_total_goals_by_away_team.class
  end

  def test_it_can_calculate_overal_average_by_team
    assert_equal 32, @league_statistics.overall_average_scores_by_away_team.count
    assert_equal Hash, @league_statistics.overall_average_scores_by_away_team.class
    assert_equal 2.2450592885375493, @league_statistics.overall_average_scores_by_away_team["6"]
  end

  def test_it_can_create_an_away_goals_and_team_id_hash
    assert_equal 32, @league_statistics.total_goals_by_away_team.count
    assert_equal Hash, @league_statistics.total_goals_by_away_team.class
    assert_equal 458, @league_statistics.total_goals_by_away_team["20"]
  end

  def test_it_can_group_team_id_with_game_teams_objects
    assert_equal "3", @league_statistics.team_by_id.keys[0]
    assert_equal "6", @league_statistics.team_by_id.keys[1]
  end

  def test_average_goals_all_seasons_by_id
    assert_equal ["3", 2.13], @league_statistics.average_goals_all_seasons_by_id.first
  end

  def test_total_games_by_id
    assert_equal ["3", 531], @league_statistics.total_games_by_id.first
  end

  def test_total_goals_by_id
    assert_equal ["3", 1129], @league_statistics.total_goals_by_id.first
  end

  def test_goals
    assert_equal 32, @league_statistics.goals.keys.count
    assert_equal 2.1018867924528304, @league_statistics.goals["3"]
    assert_equal 2.3884892086330933, @league_statistics.goals["5"]
  end

  def test_home_team_hash
    assert_equal 32, @league_statistics.home_team.keys.count
    assert_equal Hash, @league_statistics.home_team.class
  end
end
