class TransfersController < ApplicationController
  before_action only: [:index, :new, :create] do
    authorize(params[:sender_id])
  end
  before_action :authenticate_clerk, except: [:index, :new, :create]

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

  def search
  end

  def pending
    receiver_ids = Receiver.select(:id).where(phone_number: params[:phone_number])
    unless receiver_ids.empty?
      @transfers = Transfer.select(Transfer.attribute_names - ['code']).where(receiver_id: receiver_ids).where(received: false).order(created_at: :desc)
      respond_to do |format|
        format.html
        format.json { render :json => @transfers.to_json }
        format.xml { render :xml => @transfers.to_xml } 
      end
    else
      flash[:danger] = "No hay receptores con ese número telefónico."
      redirect_to :back
    end
  end

  def get_code
    @transfer = Transfer.find(params[:id])
  end

  def complete_transfer
    transfer = Transfer.find(params[:id])
    if transfer.code == params[:code]
      transfer.update_attribute(:received, true)
      flash[:success] = "Se ha completado la transferencia de $" + transfer.amount.to_s
      redirect_to search_transfers_path
    else
      flash[:danger] = "Código de seguridad incorrecto."
      redirect_to get_transfer_code_path(transfer.id)
    end 
  end

  private
    def receiver_params
      params.require('transfer').permit(:amount, :receiver_id)
    end
end
