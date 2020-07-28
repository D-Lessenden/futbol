class LeagueStatistics

  def team_by_id
    team_by_id = @game_teams.group_by do |team|
      team.team_id
    end
  end
end
