require "minitest/autorun"
require "minitest/pride"
require "mocha/minitest"
require "./test/test_helper"
require "./lib/game_teams"

class GameTeamsTest < Minitest::Test
  def setup
      info = {
        :game_id => "2012030221",
        :team_id => "3",
        :hoa => "away",
        :result => "LOSS",
        :settled_in => "OT",
        :head_coach => "John Tortorella",
        :goals => 2,
        :shots => 8,
        :tackles => 44,
        :pim => 8,
        :powerPlayOpportunities => 3,
        :powerPlayGoals => 0,
        :faceOffWinPercentage => 44.8,
        :giveaways => 17,
        :takeaways => 7
        }

        @game_teams = GameTeams.new(info)
    end

    def test_it_exists

      assert_instance_of GameTeams, @game_teams
    end

    def test_it_has_attributes
      
      assert_equal "2012030221", @game_teams.game_id
      assert_equal "3", @game_teams.team_id
      assert_equal "away", @game_teams.hoa
      assert_equal "LOSS", @game_teams.result
      assert_equal "OT", @game_teams.settled_in
      assert_equal "John Tortorella", @game_teams.head_coach
      assert_equal 2, @game_teams.goals
      assert_equal 8, @game_teams.shots
      assert_equal 44, @game_teams.tackles
      assert_equal 8, @game_teams.pim
      assert_equal 3, @game_teams.powerPlayOpportunities
      assert_equal 0, @game_teams.powerPlayGoals
      assert_equal 44.8, @game_teams.faceOffWinPercentage
      assert_equal 17, @game_teams.giveaways
      assert_equal 7, @game_teams.takeaways
    end
end
