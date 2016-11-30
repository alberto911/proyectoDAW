class CreateReceivers < ActiveRecord::Migration
  def change
    create_table :receivers do |t|
      t.string :name
      t.string :last_name
      t.string :phone_number

      t.timestamps
    end
  end
end
