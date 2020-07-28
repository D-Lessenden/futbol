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
    assert_equal 32, @stat_tracker.away_teams_game_count_by_team_id.count
    assert_equal Hash, @stat_tracker.away_teams_game_count_by_team_id.class
    assert_equal 266, @stat_tracker.away_teams_game_count_by_team_id["3"]
    assert_nil @stat_tracker.away_teams_game_count_by_team_id["56"]
  end

  def test_it_can_find_highest_total_goals_by_away_team
    assert_equal String, @stat_tracker.highest_total_goals_by_away_team[0].class
    assert_equal Integer, @stat_tracker.highest_total_goals_by_away_team[1].class
    assert_equal 2, @stat_tracker.highest_total_goals_by_away_team.count
    assert_equal Array, @stat_tracker.highest_total_goals_by_away_team.class
  end

  def test_it_can_calculate_overal_average_by_team
    assert_equal 32, @stat_tracker.overall_average_scores_by_away_team.count
    assert_equal Hash, @stat_tracker.overall_average_scores_by_away_team.class
    assert_equal 2.2450592885375493, @stat_tracker.overall_average_scores_by_away_team["6"]
  end

  def test_it_can_create_an_away_goals_and_team_id_hash
    assert_equal 32, @stat_tracker.total_goals_by_away_team.count
    assert_equal Hash, @stat_tracker.total_goals_by_away_team.class
    assert_equal 458, @stat_tracker.total_goals_by_away_team["20"]
  end

  def test_it_can_group_team_id_with_game_teams_objects

  assert_equal "3", @stat_tracker.team_by_id.keys[0]
  assert_equal "6", @stat_tracker.team_by_id.keys[1]
  end

  def test_average_goals_all_seasons_by_id

  assert_equal ["3", 2.13], @stat_tracker.average_goals_all_seasons_by_id.first
  end

  def test_total_games_by_id

  assert_equal ["3", 531], @stat_tracker.total_games_by_id.first
  end
end
