class EmployeesController < ApplicationController
  before_action :authenticate_admin

  def new
    @user = User.new
  end

  def create
    employee = Employee.new(employee_params)
    if employee.save
      @user = User.new(user_params)
      @user.userable = employee
      if @user.save
        flash[:success] = "Empleado creado exitosamente."
        redirect_to root_path
      else
        render 'new'
      end
    else
      render 'new'
    end
  end

  def show
    
  end

  private
    def user_params
      params.require(:user).permit(:name, :last_name, :mail, :password)
    end

    def employee_params
      params.require(:employee).permit(:is_admin)
    end
end
