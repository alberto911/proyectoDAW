class AddPasswordDigestToSenders < ActiveRecord::Migration
  def change
    add_column :senders, :password_digest, :string
  end
end
