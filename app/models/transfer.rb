class Transfer < ActiveRecord::Base
  belongs_to :sender
  belongs_to :receiver
 
  validates :amount, presence: true

  def self.daily_amounts
    Transfer.group_by_day(:created_at).sum(:amount)
  end

  def self.completed
    Transfer.where(received: true).count
  end

  def self.pending
    Transfer.where(received: false).count
  end

  def self.daily_number
    Transfer.group_by_day(:created_at).count
  end
end
