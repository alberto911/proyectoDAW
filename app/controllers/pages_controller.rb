class PagesController < ApplicationController
  before_action :authenticate_admin, only: :dashboard

  def home
  end

  def dashboard
    @employees = Employee.where.not(id: current_user.userable_id)
    @total = Sender.total + Receiver.total
    @completed = Transfer.completed
    @pending = Transfer.pending
    @deposits = Operation.deposits
    @withdrawals = Operation.withdrawals
  end
end
