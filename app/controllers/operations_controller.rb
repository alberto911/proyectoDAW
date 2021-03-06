class OperationsController < ApplicationController
  before_action except: [:daily_amounts, :daily_number] do
    authorize(params[:sender_id])
  end
  before_action :authenticate_admin, only: [:daily_amounts, :daily_number]

  def index
    @sender = current_user.userable
    @operations = @sender.operations
    respond_to do |format|
      format.html
      format.json { render :json => @operations.to_json }
      format.xml { render :xml => @operations.to_xml } 
    end
  end

  def new_deposit
    @sender = current_user.userable
    @operation = Operation.new
  end

  def new_withdrawal
    @sender = current_user.userable
    @operation = Operation.new
  end

  def create
    @operation = Operation.new(receiver_params)
	@operation.amount *= -1 if params[:type] == 'withdrawal'
    @sender = current_user.userable

    if @sender.enough_money?(@operation.amount)
      if @operation.save
	    @sender.operations << @operation
        @sender.update_money(@operation.amount)
        flash[:success] = "Se realizó la operación correctamente."
        redirect_to sender_path(@sender.id)
      else
        render params[:type] == 'deposit' ? 'new_deposit' : 'new_withdrawal'
      end
    else
      flash[:danger] = "La cantidad excede el total de tu cuenta."
      redirect_to sender_path(@sender.id) 
    end
  end

  def daily_amounts
    render json: Operation.daily_amounts 
  end

  def daily_number
    render json: Operation.daily_number.chart_json
  end

  private
    def receiver_params
      params.require('operation').permit(:amount)
    end
end
