require "./test/test_helper"

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
    @csv_data = CSVData.new(locations)
    @team_statistics = @csv_data.team_statistics
  end

  def test_it_exists
    assert_instance_of TeamStatistics, @team_statistics
  end

  def test_it_can_identify_favorite_opponent
    assert_equal "DC United", @team_statistics.favorite_opponent("18")
  end

  def test_it_can_find_rival
    assert_equal "Houston Dash", @team_statistics.rival("18")

  end


  def test_it_can_calculate_average_win_percentage
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
    assert_equal 31, @team_statistics.opponents_of("18").count
    assert_equal Hash, @team_statistics.opponents_of("18").class

    assert_equal 30, @team_statistics.opponents_of("54").count
    assert_equal Hash, @team_statistics.opponents_of("54").class
  end

  def test_it_pair_goals_scored_with_each_instance

  assert_equal [2, 3, 1, 0, 5, 4, 7], @team_statistics.team_goals("18").keys
  end

  def test_it_can_find_fewest_goals_scored_for_team
    assert_equal 0, @team_statistics.fewest_goals_scored("18")
  end

  def test_it_can_find_most_goals_scored_for_team
    assert_equal 7, @team_statistics.most_goals_scored("18")
  end

  def test_games_by_team

  assert_equal 8, @team_statistics.games_by_team("18").first.shots
  end

  def test_season_hash
    assert_equal 6, @team_statistics.season_hash.keys.count
    assert_equal ["20122013", "20162017", "20142015", "20152016", "20132014", "20172018"], @team_statistics.season_hash.keys
  end

  def test_game_ids_by_season
    assert_equal 6, @team_statistics.game_ids_by_season.keys.count
    assert_equal ["20122013", "20162017", "20142015", "20152016", "20132014", "20172018"], @team_statistics.game_ids_by_season.keys
    assert_equal 806, @team_statistics.game_ids_by_season["20122013"].count
  end

  def test_games_by_season
    assert_equal 6, @team_statistics.games_by_season.count
    assert_equal 2, @team_statistics.games_by_season["20122013"].first.goals
    assert_equal "3", @team_statistics.games_by_season["20122013"].first.team_id
    assert_equal "LOSS", @team_statistics.games_by_season["20122013"].first.result
  end

  def test_season_games
    assert_equal 14882, @team_statistics.season_games.count
    assert_equal "John Tortorella", @team_statistics.season_games.first.head_coach
    assert_equal "2012030221", @team_statistics.season_games.first.game_id
  end

  def test_team_games_per_season
    @team_statistics.team_games_per_season("6")
    assert_equal 70, @team_statistics.team_games_per_season("6")["2012"].count
    assert_equal 94, @team_statistics.team_games_per_season("6")["2017"].count
  end

  def test_it_can_create_a_win_hash
    expected = {
        "2012"=>[38, 71],
      "2016"=>[33, 86],
      "2014"=>[44, 105],
      "2015"=>[43, 89],
      "2013"=>[47, 101],
      "2017"=>[31, 82]
      }
    assert_equal expected, @team_statistics.win_hash("16")

    expected2 = {
        "2012"=>[38, 70],
        "2016"=>[45, 88],
        "2014"=>[31, 82],
        "2015"=>[33, 82],
        "2013"=>[54, 94],
        "2017"=>[50, 94]
        }

  assert_equal expected2, @team_statistics.win_hash("6")

  end

  def test_best_season
   assert_equal "20132014", @team_statistics.best_season("6")
  end

  def test_worst_season
    assert_equal "20142015", @team_statistics.worst_season("6")
  end

  def test_it_can_calculate_average_win_percentage
    assert_equal 0.44, @team_statistics.average_win_percentage("16")
    assert_equal 0.48, @team_statistics.average_win_percentage("5")

  end

  def test_it_can_retrieve_team_info_from_team_id
    expected = {"team_id" => "18", "franchise_id" => "34", "team_name" => "Minnesota United FC", "abbreviation" => "MIN", "link" => "/api/v1/teams/18" }

    assert_equal expected, @team_statistics.team_info("18")
  end


end
