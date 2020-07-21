<<<<<<< HEAD

class GameTeams
attr_reader :game_id, :team_id, :hoa, :result, :settled_in, :head_coach, :goals, :shots, :tackles, :pim, :powerplayopportunities, :powerplaygoals, :faceoffwinpercentage, :giveaways, :takeaways
def initialize(params)
  @game_id = params[:game_id]
  @team_id = params[:team_id]
  @hoa = params[:hoa] #home or away
  @result = params[:result]
  @settled_in = params[:settled_in]
  @head_coach =  params[:head_coach]
  @goals = params[:goals]
  @shots = params[:shots]
  @tackles = params[:tackles]
  @pim = params[:pim]
  @powerplayopportunities = params[:powerplayopportunities]
  @powerplaygoals = params[:powerplaygoals]
  @faceoffwinpercentage = params[:faceoffwinpercentage]
  @giveaways = params[:giveaways]
  @takeaways = params[:takeaways]
end

end
=======
class GameTeams
  attr_reader :game_id,
              :team_id,
              :hoa,
              :result,
              :settled_in,
              :head_coach,
              :goals,
              :shots,
              :tackles,
              :pim,
              :powerplayopportunities,
              :powerplaygoals,
              :faceoffwinpercentage,
              :giveaways,
              :takeaways

  def initialize(params)
    @game_id = params[:game_id]
    @team_id = params[:team_id]
    @hoa = params[:hoa]
    @result = params[:result]
    @settled_in = params[:settled_in]
    @head_coach = params[:head_coach]
    @goals = params[:goals].to_i
    @shots = params[:shots].to_i
    @tackles = params[:tackles].to_i
    @pim = params[:pim].to_i
    @powerplayopportunities = params[:powerplayopportunities].to_i
    @powerplaygoals = params[:powerplaygoals].to_i
    @faceoffwinpercentage = params[:faceoffwinpercentage].to_f
    @giveaways = params[:giveaways].to_i
    @takeaways = params[:takeaways].to_i
  end
end
>>>>>>> 971a1d18896e87ec026386b5fa4aa4dece98446e
