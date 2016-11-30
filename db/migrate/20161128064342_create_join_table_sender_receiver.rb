class CreateJoinTableSenderReceiver < ActiveRecord::Migration
  def change
    create_join_table :senders, :receivers
  end
end
