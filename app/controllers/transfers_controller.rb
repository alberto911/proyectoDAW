class TransfersController < ApplicationController
  before_action do
    authorize(params[:sender_id])
  end

  def index
    @sender = current_user.userable
    @transfers = @sender.transfers
    respond_to do |format|
      format.html
      format.json { render :json => @transfers.to_json }
      format.xml { render :xml => @transfers.to_xml } 
    end
  end

  def new
    @sender = current_user.userable
    @transfer = Transfer.new
  end

  def create
    @transfer = Transfer.new(receiver_params)
    @transfer.code = "%04d" % rand(10000) 
    @sender = current_user.userable

    if @sender.enough_money?(-@transfer.amount)
      if @transfer.save
        @sender.transfers << @transfer
        @sender.update_money(-@transfer.amount)
        @transfer.receiver.update_money(@transfer.amount)
        flash[:success] = "Se realizó la transferencia correctamente. El código de seguridad es " + @transfer.code + "."
        redirect_to sender_path(@sender.id)
      else
        render 'new'
      end
    else
      flash[:danger] = "La cantidad excede el total de tu cuenta."
      redirect_to sender_path(@sender.id) 
    end
  end

  private
    def receiver_params
      params.require('transfer').permit(:amount, :receiver_id)
    end
end
