class Transfer < ActiveRecord::Base
  belongs_to :sender
  belongs_to :receiver
 
  validates :amount, presence: true
end
