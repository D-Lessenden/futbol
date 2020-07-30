require_relative "./csv_data"

class StatTracker

  def self.from_csv(locations)
    StatTracker.new(locations)
  end

  def initialize(locations)
    csv_data = CSVData.new(locations)
    @games_statistics = csv_data.games_statistics
    @team_statistics = csv_data.team_statistics
    @league_statistics = csv_data.league_statistics
    @season_statistics = csv_data.season_statistics
  end

  def highest_total_score
   @games_statistics.highest_total_score
  end

  def lowest_total_score
    @games_statistics.lowest_total_score
  end

  def percentage_home_wins
   @games_statistics.percentage_home_wins
  end

  def percentage_visitor_wins
    @games_statistics.percentage_visitor_wins
  end

  def percentage_ties
   @games_statistics.percentage_ties
  end

  def count_of_games_by_season
    @games_statistics.count_of_games_by_season
  end

  def average_goals_per_game
   @games_statistics.average_goals_per_game
  end

  def average_goals_by_season
    @games_statistics.average_goals_by_season
  end

  def winningest_coach(season)
    @season_statistics.winningest_coach(season)
  end

  def worst_coach(season)
    @season_statistics.worst_coach(season)
  end

  def most_accurate_team(seasonID)
    @season_statistics.most_accurate_team(seasonID)
  end

  def least_accurate_team(seasonID)
    @season_statistics.least_accurate_team(seasonID)
  end

  def fewest_tackles(seasonID)
    @season_statistics.fewest_tackles(seasonID)
  end

  def most_tackles(seasonID)
    @season_statistics.most_tackles(seasonID)
  end
  
  def count_of_teams
    @league_statistics.count_of_teams
  end

  def best_offense
    @league_statistics.best_offense
  end

  def worst_offense
    @league_statistics.worst_offense
  end

  def highest_scoring_visitor
    @league_statistics.highest_scoring_visitor
  end

  def highest_scoring_home_team
    @league_statistics.highest_scoring_home_team
  end

  def lowest_scoring_visitor
    @league_statistics.lowest_scoring_visitor
  end

  def lowest_scoring_home_team
    @league_statistics.lowest_scoring_home_team
  end

  def team_info(team_id)
    @team_statistics.team_info(team_id)
  end

  def average_win_percentage(team_id)
    @team_statistics.average_win_percentage(team_id)
  end

  def most_goals_scored(team_id)
    @team_statistics.most_goals_scored(team_id)
  end

  def fewest_goals_scored(team_id)
    @team_statistics.fewest_goals_scored(team_id)
  end

  def best_season(team_id)
    @team_statistics.best_season(team_id)
  end

  def worst_season(team_id)
    @team_statistics.worst_season(team_id)
  end

  def favorite_opponent(team_id)
    @team_statistics.favorite_opponent(team_id)
  end

  def rival(team_id)
    @team_statistics.rival(team_id)
  end

end
