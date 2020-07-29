require "./test/test_helper"

class StatTrackerTest < MiniTest::Test

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
  end

  def test_it_exist
    assert_instance_of StatTracker, @stat_tracker
  end

  def test_count_of_teams
    assert_equal 32, @stat_tracker.count_of_teams
  end

  def test_highest_scoring_home_team
    assert_equal "Reign FC", @stat_tracker.highest_scoring_home_team
  end

   def test_highest_scoring_home_team
     assert_equal "Reign FC", @stat_tracker.highest_scoring_home_team
   end

   def test_lowest_scoring_home_team
     assert_equal "Utah Royals FC", @stat_tracker.lowest_scoring_home_team
   end

  def test_it_can_calculate_highest_scoring_visitor
    assert_equal "FC Dallas", @stat_tracker.highest_scoring_visitor
  end

  def test_lowest_scoring_home_team
    assert_equal "Utah Royals FC", @stat_tracker.lowest_scoring_home_team
  end

  def test_it_can_find_lowest_scoring_visitor
    assert_equal "San Jose Earthquakes", @stat_tracker.lowest_scoring_visitor
  end

  def test_lowest_scoring_home_team

    assert_equal "Utah Royals FC" ,@stat_tracker.lowest_scoring_home_team
  end

  def test_it_can_return_best_offense

    assert_equal "Reign FC", @stat_tracker.best_offense
  end

  def test_it_can_return_worst_offense

    assert_equal "Utah Royals FC", @stat_tracker.worst_offense
  end

  def test_it_can_retrieve_team_info_from_team_id
    expected = {"team_id" => "18", "franchise_id" => "34", "team_name" => "Minnesota United FC", "abbreviation" => "MIN", "link" => "/api/v1/teams/18" }

    assert_equal expected, @stat_tracker.team_info("18")
  end

  def test_best_season
    assert_equal "20132014", @stat_tracker.best_season("6")
  end

  def test_worst_season
     assert_equal "20142015", @stat_tracker.worst_season("6")
  end

  def test_best_season
    assert_equal "20132014", @stat_tracker.best_season("6")
  end

  def test_it_can_identify_favorite_opponent
  assert_equal "DC United", @stat_tracker.favorite_opponent("18")
  end

  def test_it_can_find_rival
    assert_equal "Houston Dash", @stat_tracker.rival("18")

  end

  def test_it_can_find_most_goals_scored_for_team
    assert_equal 7, @stat_tracker.most_goals_scored("18")
  end

  def test_it_can_find_fewest_goals_scored_for_team
    assert_equal 0, @stat_tracker.fewest_goals_scored("18")
  end

  def test_best_season
    assert_equal "20132014", @stat_tracker.best_season("6")
  end

  def test_worst_season

    assert_equal "20142015", @stat_tracker.worst_season("6")
  end



end
