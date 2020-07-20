require './test/test_helper'
require "./lib/stat_tracker"
require "./lib/games"
require "pry"

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

  def test_StatTracker_can_find_highest_total_score

    assert_equal 11, @stat_tracker.highest_total_score
  end
  
  def test_can_find_lowest_total_score

    assert_equal 0, @stat_tracker.lowest_total_score
  end

  def test_can_find_percentage_home_wins

    assert_equal 0.44, @stat_tracker.percentage_home_wins
  end

  def test_can_find_percentage_visitor_wins

    assert_equal 0.36, @stat_tracker.percentage_visitor_wins
  end 
  def test_can_find_percentage_ties
    
    assert_equal 0.20, @stat_tracker.percentage_ties
  end 

  def test_it_can_count_of_games_by_season
    
    expected = {"20122013"=>806, "20162017"=>1317, "20142015"=>1319, "20152016"=>1321, "20132014"=>1323, "20172018"=>1355}
    assert_equal expected, @stat_tracker.count_of_games_by_season
  end
end

# game.find {|game| game["date_time"] == "5/16/13"; return game["venue"] }
