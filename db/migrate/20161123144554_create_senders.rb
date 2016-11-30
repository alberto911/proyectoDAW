class CreateSenders < ActiveRecord::Migration
  def change
    create_table :senders do |t|
      t.string :name
      t.string :last_name
      t.string :mail

      t.timestamps
    end
  end
end
