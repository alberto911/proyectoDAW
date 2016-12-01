class Receiver < ActiveRecord::Base
  has_and_belongs_to_many :senders
  has_many :transfers

  validates :name, presence: true, length: { maximum: 50 }
  validates :last_name, presence: true, length: { maximum: 50 }
  validates :phone_number, presence: true, length: { maximum: 20 }

  def update_money(amount)
    self.update_attribute(:money, self.money + amount)
  end

  def self.total
    Receiver.sum(:money)
  end
end
