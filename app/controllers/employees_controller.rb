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
        redirect_to dashboard_path
      else
        render 'new'
      end
    else
      render 'new'
    end
  end

  def show
  end

  def destroy
    employee = Employee.find(params[:id])
    employee.user.destroy
    employee.destroy
    flash[:success] = "Se eliminó correctamente al empleado."
    redirect_to :back
  end

  def index
    @employees = Employee.where.not(id: current_user.userable_id)
    respond_to do |format|
      format.html
      format.json { render :json => @employees.to_json }
      format.xml { render :xml => @employees.to_xml } 
    end
  end

  private
    def user_params
      params.require(:user).permit(:name, :last_name, :mail, :password)
    end

    def employee_params
      params.require(:employee).permit(:is_admin)
    end
end
