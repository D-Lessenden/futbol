class LeagueStatistics

  def team_by_id
    team_by_id = @game_teams.group_by do |team|
      team.team_id
    end
  end

  def away_teams_game_count_by_team_id
    games_by_team_id = @games.reduce(Hash.new { |h,k| h[k]=[] }) do |result, game|
      result[game.away_team_id] << game.game_id
      result
    end
    games_count_by_team_id = {}
    games_by_team_id.each do |team_id, games_array|
      games_count_by_team_id[team_id] = games_array.count
    end
    games_count_by_team_id
  end

  def overall_average_scores_by_away_team
    team_id = total_goals_by_away_team.keys
    total_away_goals = total_goals_by_away_team.values
    total_away_games = away_teams_game_count_by_team_id.values
    teams_away_goals_and_total_games = team_id.zip(total_away_goals, total_away_games)
    over_all_average_by_team = {}
    teams_away_goals_and_total_games.each do |team_id, total_away_goals, total_away_games|
      over_all_average_by_team[team_id] = total_away_goals.to_f/total_away_games
    end
    over_all_average_by_team
  end

  def total_goals_by_away_team
    away_goals = Hash.new{0}
    @games.sum do |game|
      away_goals[game.away_team_id] += game.away_goals
    end
    away_goals
  end

  def lowest_scoring_home_team
    goals
    id = goals.min_by {|team, num_of_goals| num_of_goals}
    @teams.find {|team| team.team_id == id[0]}.teamname
  end

  def highest_scoring_visitor
    best_team = overall_average_scores_by_away_team.max_by do |team_id, average_goals|
        average_goals
    end
    @teams.find do |team|
      team.team_id == best_team[0]
    end.teamname
  end

  def lowest_scoring_visitor
    worst_team = overall_average_scores_by_away_team.min_by do |team_id, average_goals|
      average_goals
    end
    @teams.find do |team|
      team.team_id == worst_team[0]
    end.teamname
  end

  def best_offense
    team_by_id
    total_games_by_id
    total_goals_by_id
    average_goals_all_seasons_by_id
    highest = average_goals_all_seasons_by_id.max_by {|id, avg| avg}
    best_offense = @teams.find {|team| team.teamname if team.team_id == highest[0]}.teamname
    best_offense
  end

  def worst_offense
    team_by_id
    total_games_by_id
    total_goals_by_id
    average_goals_all_seasons_by_id
    lowest = average_goals_all_seasons_by_id.min_by {|id, avg| avg}
    worst_offense = @teams.find {|team| team.teamname if team.team_id == lowest[0]}.teamname
    worst_offense
  end

  def highest_total_goals_by_away_team
    total_goals_by_away_team.max_by do |team_id, total_goals|
      total_goals
    end
  end

  def average_goals_all_seasons_by_id
    average_goals_all_seasons_by_id = {}
    total_goals_by_id.each do |id, goals|
      average_goals_all_seasons_by_id[id] = (goals.to_f / total_games_by_id[id] ).round(2)
    end
    average_goals_all_seasons_by_id
  end

  def total_games_by_id
    total_games_by_id = {}
    team_by_id.map { |id, games| total_games_by_id[id] = games.length}
    total_games_by_id
  end

  def total_goals_by_id
    total_goals_by_id = {}
    team_by_id.map { |id, games| total_goals_by_id[id] = games.sum {|game| game.goals}}
    total_goals_by_id
  end

end
