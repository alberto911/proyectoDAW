class Operation < ActiveRecord::Base
  belongs_to :sender
  validates :amount, presence: true
end
