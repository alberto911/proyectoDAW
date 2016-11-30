class LoginsController < ApplicationController
  def new

  end

  def create
    user = User.find_by(mail: params[:mail])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:success] = "Has iniciado sesión."
      if user.userable_type == 'Sender'
        redirect_to sender_path(user.userable_id)
      else
        redirect_to new_employee_path
      end
    else
      flash.now[:danger] = "Tus credenciales son incorrectas."
      render 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = "Has cerrado sesión."
    redirect_to root_path
  end
end
