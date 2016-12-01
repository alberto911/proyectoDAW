class Operation < ActiveRecord::Base
  belongs_to :sender
  validates :amount, presence: true

  def self.daily_amounts
    Operation.group_by_day(:created_at).sum(:amount)
  end

  def self.daily_number
    operations = Operation.group("amount >= 0").group_by_day(:created_at).count
    mappings = {0 => 'Retiro', 1 => 'Depósito'}
    operations.each_key { |k| k[0] = mappings[k.first] }
  end

  def self.deposits
    Operation.where("amount > 0").count
  end

  def self.withdrawals
    Operation.where("amount < 0").count
  end
end
