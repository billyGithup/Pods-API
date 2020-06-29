class EmployeesController < ApplicationController
  def index
    employees = Employee.all
    render json: employees, status: :ok
  end

  def show
    employee = Employee.find(params[:id])
    render json: employee, status: :ok
  rescue
    render json: {
        message: 'Record is not found!'
    }, status: :not_found
  end

  def create
    new_employee = Employee.create!(whitelisted_params)
    render json: new_employee, status: :created
  rescue
    render json: {
        message: 'Name only allow letters, spaces, apostrophe, and dots. Email only allows example@example.com format.'
    }, status: :unprocessable_entity
  end

  def update
    employee = Employee.find(params[:id])
    employee.update!(whitelisted_params)
    render json: employee, status: :ok
  rescue ActiveRecord::RecordNotFound
    render json: {
        message: 'Record is not found!'
    }, status: :not_found
  rescue ActiveRecord::RecordInvalid
    render json: {
        message: 'Name only allow letters, spaces, apostrophe, and dots. Email only allows example@example.com format.'
    }, status: :unprocessable_entity
  end

  def destroy
    employee = Employee.find(params[:id])
    employee.destroy
    render json: Employee.all, status: :ok
  rescue
    render json: {
        message: 'Record is not found!'
    }, status: :not_found
  end

  private
  def whitelisted_params
    params.require(:employee).permit(:first_name, :last_name, :email)
  end
end
