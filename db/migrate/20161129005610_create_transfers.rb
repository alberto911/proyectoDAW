class CreateTransfers < ActiveRecord::Migration
  def change
    create_table :transfers do |t|
      t.belongs_to :sender, foreign_key: true
      t.belongs_to :receiver, foreign_key: true 
      t.decimal :amount, precision: 10, scale: 2
      t.timestamp :created_at
    end
  end
end
