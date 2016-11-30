class ChangeTransfers < ActiveRecord::Migration
  def change
    change_table :transfers do |t|
      t.rename :recibido, :received
    end
  end
end
