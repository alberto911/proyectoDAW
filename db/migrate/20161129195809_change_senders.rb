class ChangeSenders < ActiveRecord::Migration
  def change
    change_table :senders do |t|
      t.remove :name, :last_name, :mail, :password_digest
    end
  end
end
