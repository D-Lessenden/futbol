require "minitest/autorun"
require "minitest/pride"
require "mocha/minitest"
require "./lib/stat_tracker"
require "./lib/team_statistics"
require "./lib/games"
require "./lib/teams"
require "./lib/game_teams"

class TeamStatisticsTest < Minitest::Test
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
    @games = @stat_tracker.games
    @teams = @stat_tracker.teams
    @game_teams = @stat_tracker.game_teams

    @team_statistics = TeamStatistics.new(@games, @teams, @game_teams)
  end
  def test_it_exists
    assert_instance_of TeamStatistics, @team_statistics
  end

  def test_it_can_identify_favorite_opponent
    # skip
  assert_equal "DC United", @team_statistics.favorite_opponent("18")
  end

  def test_it_can_calculate_average_win_percentage
    skip
    expected = {
       "19"=>0.4411764705882353,
       "52"=>0.45161290322580644,
       "21"=>0.4375,
       "16"=>0.47368421052631576,
       "1"=>0.5,
       "29"=>0.4666666666666667,
       "8"=>0.4,
       "23"=>0.3333333333333333,
       "15"=>0.3,
       "25"=>0.48148148148148145,
       "20"=>0.3333333333333333,
       "28"=>0.44,
       "24"=>0.41935483870967744,
       "5"=>0.25,
       "2"=>0.5,
       "7"=>0.6,
       "14"=>0.8,
       "22"=>0.6666666666666666,
       "3"=>0.4,
       "10"=>0.2,
       "9"=>0.6,
       "26"=>0.3888888888888889,
       "6"=>0.4,
       "12"=>0.3,
       "30"=>0.37037037037037035,
       "27"=>0.3333333333333333,
       "17"=>0.2857142857142857,
       "53"=>0.5,
       "4"=>0.3,
       "54"=>0.3333333333333333,
       "13"=>0.1}
    assert_equal expected, @team_statistics.average_win_percentage_by_opponents_of("18")
  end

  def test_it_can_count_games_won_against_opponents
    skip
    expected = {
     "19"=>15,
     "52"=>14,
     "21"=>14,
     "16"=>18,
     "1"=>5,
     "29"=>7,
     "8"=>4,
     "23"=>6,
     "15"=>3,
     "25"=>13,
     "20"=>6,
     "28"=>11,
     "24"=>13,
     "5"=>4,
     "2"=>5,
     "7"=>6,
     "14"=>8,
     "22"=>12,
     "3"=>4,
     "10"=>2,
     "9"=>6,
     "26"=>7,
     "6"=>4,
     "12"=>3,
     "30"=>10,
     "27"=>2,
     "17"=>4,
     "53"=>6,
     "4"=>3,
     "54"=>1,
     "13"=>1}
    assert_equal expected, @team_statistics.games_won_by_team("18")

  end

  def test_it_can_find_all_opponents
    skip
    assert_equal 31, @team_statistics.opponents_of("18").count
    assert_equal Hash, @team_statistics.opponents_of("18").class

    assert_equal 30, @team_statistics.opponents_of("54").count
    assert_equal Hash, @team_statistics.opponents_of("54").class
  end

  def test_it_can_find_team_name
    skip
    assert_equal "Minnesota United FC", @team_statistics.find_team_name("18")
    assert_equal "Reign FC", @team_statistics.find_team_name("54")
  end


end
