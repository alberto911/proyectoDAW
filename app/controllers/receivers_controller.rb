class ReceiversController < ApplicationController
  before_action do
    authorize(params[:sender_id])
  end

  def index
    @sender = current_user.userable
    @receivers = @sender.receivers
    respond_to do |format|
      format.html
      format.json { render :json => @receivers.to_json }
      format.xml { render :xml => @receivers.to_xml } 
    end
  end

  def show
    @receiver = Receiver.find(params[:id])
    @transfers = @receiver.transfers.where(sender_id: params[:sender_id]).order(created_at: :desc)
    respond_to do |format|
      format.html
      format.json { render :json => @transfers.to_json }
      format.xml { render :xml => @transfers.to_xml } 
    end
  end

  def new
    @sender = current_user.userable
    @receiver = Receiver.new
  end

  def create
    @receiver = Receiver.find_or_initialize_by(receiver_params)
    if @receiver.persisted? or @receiver.save
      sender = current_user.userable
	  sender.receivers << @receiver
      flash[:success] = "Se agregó correctamente al receptor."
      redirect_to sender_path(sender.id)
    else
      render 'new'
    end
  end

  def destroy
	@receiver = Receiver.find(params[:id])
    current_user.userable.receivers.delete(@receiver)
    flash[:success] = "Se eliminó correctamente al receptor."
    redirect_to :back
  end

  private
    def receiver_params
      params.require('receiver').permit(:name, :last_name, :phone_number)
    end
end
