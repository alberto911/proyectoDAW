class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user, :logged_in?

  def authenticate_admin
    unless logged_in? and current_user.userable.is_admin
      flash[:danger] = "Por favor inicia sesión."
      redirect_to login_path
    end
  end

  def authenticate_clerk
    unless logged_in? and current_user.userable_type == 'Employee' and not current_user.userable.is_admin
      flash[:danger] = "Por favor inicia sesión."
      redirect_to login_path
    end
  end

  def authorize(id)
    unless logged_in? and current_user.userable_type == 'Sender' and current_user.userable_id == id.to_i
      session[:user_id] = nil
      flash[:danger] = "Por favor inicia sesión."
      redirect_to login_path
    end
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !!current_user
  end
end
