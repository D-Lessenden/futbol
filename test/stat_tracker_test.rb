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

  def test_can_find_percentage_tie
     assert_equal 0.20, @stat_tracker.percentage_tie
   end

  def test_count_games_by_season
     expected = {"20122013" => 806,
                 "20162017" => 1317,
                 "20142015" => 1319,
                 "20152016" => 1321,
                 "20132014" => 1323,
                 "20172018" => 1355
                  }
     assert_equal expected, @stat_tracker.count_of_games_by_season
   end

   def test_count_of_teams
     assert_equal 32, @stat_tracker.count_of_teams
   end

   def test_home_team_hash
     assert_equal 32, @stat_tracker.home_team.keys.count
     assert_equal Hash, @stat_tracker.home_team.class
   end

   def test_goals
     assert_equal 32, @stat_tracker.goals.keys.count
     assert_equal 2.1018867924528304, @stat_tracker.goals["3"]
     assert_equal 2.3884892086330933, @stat_tracker.goals["5"]
   end

   def test_highest_scoring_home_team
     assert_equal "Reign FC", @stat_tracker.highest_scoring_home_team
   end

   def lowest_scoring_home_team
     assert_equal "asd", @stat_tracker.lowest_scoring_home_team
   end

   

  def test_best_season
    assert_equal "20132014", @stat_tracker.best_season("6")
  end

  def test_worst_season
    assert_equal "20142015", @stat_tracker.worst_season("6")
  end

  def test_find_the_fewest_tackles
   assert_equal "Atlanta United", @stat_tracker.fewest_tackles("20132014")
   assert_equal "Orlando City SC", @stat_tracker.fewest_tackles("20142015")
 end

  def test_find_the_most_tackles
    assert_equal "FC Cincinnati", @stat_tracker.most_tackles("20132014")
    assert_equal "Seattle Sounders FC", @stat_tracker.most_tackles("20142015")
  end

end#class
