require_relative "./calculatable"

class GamesStatistics
  include Calculatable
  def initialize(games, teams, game_teams)
    @games = games
    @teams = teams
    @game_teams = game_teams
  end

  def highest_total_score
    output = @games.max_by do |game|
      game.away_goals + game.home_goals
    end
    output.away_goals + output.home_goals
  end

  def lowest_total_score
    output = @games.min_by do |game|
      game.away_goals + game.home_goals
    end
    output.away_goals + output.home_goals
  end

  def percentage_home_wins
    home_games = @game_teams.select do |game|
      game.hoa == "home"
    end
    home_wins = @game_teams.select do |game|
      game.result == "WIN" && game.hoa == "home"
    end
    average(home_wins.count, home_games.count.to_f).round(2)
  end

  def percentage_visitor_wins
    total_visitor_wins = @games.select do |game|
      game.away_goals > game.home_goals
    end
    average(total_visitor_wins.length.to_f, @games.length).round(2)
  end

  def percentage_ties
    game_ties = @game_teams.select do |game|
      game.result == "TIE"
    end
    average(game_ties.count, @game_teams.count.to_f).round(2)
  end

  def count_of_games_by_season
    games_by_season = @games.group_by {|game| game.season}
    game_count_per_season = {}
    games_by_season.map {|season, game| game_count_per_season[season] = game.count}
    game_count_per_season
  end

  def average_goals_per_game
    games_count = @games.count.to_f
    sum_of_goals = (@games.map {|game| game.home_goals + game.away_goals}.to_a).sum
    average(sum_of_goals, games_count).round(2)
  end

  def average_goals_by_season
    games_by_season = @games.group_by {|game| game.season}
    goals_per_season = {}
    games_by_season.map do |season, games|
      goals_per_season[season] = games.sum do |game|
        game.away_goals + game.home_goals
      end
    end
    avg_goals_per_season = {}
    goals_per_season.each do |season, goals|
      division = (goals.to_f / count_of_games_by_season[season] ).round(2)
      avg_goals_per_season[season] = division
    end
    avg_goals_per_season
  end
end