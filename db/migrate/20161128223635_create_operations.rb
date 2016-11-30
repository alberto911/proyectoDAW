class CreateOperations < ActiveRecord::Migration
  def change
    create_table :operations do |t|
      t.belongs_to :sender, foreign_key: true
      t.decimal :amount, precision: 10, scale: 2
    end
  end
end
