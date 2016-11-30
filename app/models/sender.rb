class Sender < ActiveRecord::Base
  has_and_belongs_to_many :receivers
  has_many :operations
  has_many :transfers
  has_one :user, :as => :userable

  def update_money(amount)
    self.update_attribute(:money, self.money + amount)
  end

  def enough_money?(amount)
    self.money + amount >= 0
  end

  def daily_operations
    self.operations.group_by_day(:created_at).sum(:amount)
  end

  def daily_transfers
    query = self.transfers.group(:receiver_id).group_by_day(:created_at).sum(:amount)
    receivers = Receiver.select(:id, :name, :last_name)
    query.each do |key, value|
      r = receivers.find(key[0])
      key[0] = r.name + " " + r.last_name
    end
    query
  end
end
