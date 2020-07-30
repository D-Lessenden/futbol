module Calculatable

  def average(num1, num2)
    num1 / num2
  end

  def total(num1, num2)
    num1 + num2
  end

  def select_teams(id, csv_datas)
    result = csv_datas.select do |csv_data|
      csv_data.team_id == id
    end
    result
  end

  def opponents_hash_count(team_id, games_csv)
    opponents = Hash.new(0)
    games_csv.each do |game|
      opponents[game.home_team_id] += 1 if game.away_team_id == team_id
      opponents[game.away_team_id] += 1 if game.home_team_id == team_id
    end
    opponents
  end

  def games_won_against_opp_hash(team_id, games_csv)
    games_won_against_opp = Hash.new(0)
    games_csv.each do |game|
      games_won_against_opp[game.home_team_id] += 1 if ((game.away_team_id == team_id) && (game.away_goals > game.home_goals))
      games_won_against_opp[game.away_team_id] +=1 if ((game.home_team_id == team_id) && (game.home_goals > game.away_goals))
    end
    games_won_against_opp
  end

  def team_info_hash(team_id, teams_csv)
    team_info = {}
    team = teams_csv.find {|team| team.team_id == team_id}
    team_info["team_id"] = team.team_id
    team_info["franchise_id"] = team.franchiseid
    team_info["team_name"] = team.teamname
    team_info["abbreviation"] = team.abbreviation
    team_info["link"] = team.link
    team_info
  end

  def average_win_method(team_id, game_teams_csv)

    team_games = game_teams_csv.find_all {|team| team.team_id == team_id}
    team_games_count = team_games.count
    team_total_wins = team_games.find_all {|game| game.result == "WIN"}.count
    team_average_win_percentage = (team_total_wins / team_games_count.to_f).round(2)
    team_average_win_percentage

  end

  def average_opp_losses_against_our_team(team_id)
    average_win_percentage = {}
    games_won_by_team(team_id).each do |opp_team_id, games_won|
      opponents_of(team_id).each do |opp_team_id2, games_played|
        if opp_team_id == opp_team_id2
          average_win_percentage[opp_team_id] =
          average(games_won.to_f, games_played)
        end
      end
    end
    average_win_percentage
  end

  def find_team_name(team_id, teams_csv)
    teams_csv.find do |team|
      team.team_id == team_id
    end.teamname
  end


end
