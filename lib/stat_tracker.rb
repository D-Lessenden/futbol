require "./lib/csv_data"

class StatTracker

  def self.from_csv(locations)
    StatTracker.new(locations)
  end

  def initialize(locations)
    csv_data = CSVData.new(locations)
    @games_statistics = csv_data.games_statistics
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

end#class
