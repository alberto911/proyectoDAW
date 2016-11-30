class LoginsController < ApplicationController
  def new

  end

  def create
    user = User.find_by(mail: params[:mail])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      if user.userable_type == 'Sender'
        redirect_to sender_path(user.userable_id)
      elsif user.userable.is_admin
        redirect_to new_employee_path
      else
        redirect_to search_transfers_path
      end
    else
      flash.now[:danger] = "Tus credenciales son incorrectas."
      render 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end
end
