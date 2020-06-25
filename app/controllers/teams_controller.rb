class TeamsController < ApplicationController
  def index
    teams = Team.all
    render json: teams, status: :ok
  end

  def show
    team = Team.find(params[:id])
    render json: team, status: :ok
  rescue
    render json: {
        message: 'Record is not found!'
    }, status: :not_found
  end

  def create
    new_team = Team.create!(whitelisted_params)
    render json: new_team, status: :created
  rescue
    render json: {
        message: 'Name and Lead only allow letters, spaces, apostrophe, and dots. Active only allows Yes or No.'
    }, status: :unprocessable_entity
  end

  def update
    team = Team.find(params[:id])
    team.update!(whitelisted_params)
    render json: team, status: :ok
  rescue ActiveRecord::RecordNotFound
    render json: {
        message: 'Record is not found!'
    }, status: :not_found
  rescue ActiveRecord::RecordInvalid
    render json: {
        message: 'Name and Lead only allow letters, spaces, apostrophe, and dots. Active only allows Yes or No.'
    }, status: :unprocessable_entity
  end

  def destroy
    team = Team.find(params[:id])
    team.destroy
    render json: Team.all, status: :ok
  rescue
    render json: {
        message: 'Record is not found!'
    }, status: :not_found
  end

  private
  def whitelisted_params
    params.require(:team).permit(:name, :lead, :active)
  end
end
