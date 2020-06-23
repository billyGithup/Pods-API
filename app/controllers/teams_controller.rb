class TeamsController < ApplicationController
  def index
    team = Team.all
    render json: team, status: :ok
  end
end
