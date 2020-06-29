class TeamsController < ApplicationController
  def index
    teams = Team.all
    render json: teams, status: :ok
  end

  def show
    team = Team.find(params[:id])
    render json: team, status: :ok
  end

  def create
    new_team = Team.create!(whitelisted_team_params)
    render json: new_team, status: :created
  end

  def update
    team = Team.find(params[:id])
    team.update!(whitelisted_team_params)
    render json: team, status: :ok
  end

  def destroy
    team = Team.find(params[:id])
    team.destroy
    render json: Team.all, status: :ok
  end

  def add_employee
    team = Team.find(params[:id])
    employee = Employee.create!(sanitized_employee_params)
    team.memberships.create(employee: employee)
    render json: team.employees, status: :ok
  end

  def list_employees
    team = Team.find(params[:id])
    render json: team.employees, status: :ok
  end

  private
  def whitelisted_team_params
    params.require(:team).permit(:name, :lead, :active)
  end

  def sanitized_employee_params
    params.require(:employee).permit(:first_name, :last_name, :email)
  end
end
