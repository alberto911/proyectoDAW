class AddMoneyToReceivers < ActiveRecord::Migration
  def change
    add_column :receivers, :money, :decimal, precision: 10, scale: 2, default: 0
  end
end
