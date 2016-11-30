class SendersController < ApplicationController
  before_action except: [:new, :create] do
    authorize(get_id)
  end

  def new
    @user = User.new
  end

  def create
    sender = Sender.new()
    if sender.save
      @user = User.new(user_params)
      @user.userable = sender
      if @user.save
        flash[:success] = "Cuenta creada exitosamente."
        redirect_to root_path
      else
        render 'new'
      end
    else
      render 'new'
    end
  end

  def show
    @user = current_user
    respond_to do |format|
      format.html
      format.json { render :json => @user.to_json }
      format.xml { render :xml => @user.to_xml }
    end
  end

  def daily_operations
    render json: current_user.userable.daily_operations
  end

  def daily_transfers
    render json: current_user.userable.daily_transfers.chart_json
  end

  private
    def user_params
      params.require(:user).permit(:name, :last_name, :mail, :password)
    end

    def get_id
      params.has_key?(:sender_id) ? params[:sender_id] : params[:id]
    end
end
