class AddIndexToReceivers < ActiveRecord::Migration
  def change
    add_index(:receivers, [:name, :last_name, :phone_number], unique: true)
  end
end
