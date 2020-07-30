require "minitest/autorun"
require "minitest/pride"
require "mocha/minitest"
require "./lib/stat_tracker"
require "./lib/csv_data"

class CSVDataTest < Minitest::Test
  def setup
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }
    StatTracker.from_csv(locations)
    @csv_data = CSVData.new(locations)
    @games = @csv_data.games
    @teams = @csv_data.teams
    @game_teams = @csv_data.game_teams

  end

  def test_it_exists
    assert_instance_of CSVData, @csv_data
  end

  def test_it_has_attributes
    assert_equal @games, @csv_data.games
    assert_equal @teams, @csv_data.teams
    assert_equal @game_teams, @csv_data.game_teams
    assert_equal GamesStatistics, @csv_data.games_statistics.class
    assert_equal LeagueStatistics, @csv_data.league_statistics.class
    assert_equal SeasonStatistics, @csv_data.season_statistics.class
    assert_equal TeamStatistics, @csv_data.team_statistics.class
  end

end
