class AddCreatedAtToOperations < ActiveRecord::Migration
  def change
    add_column :operations, :created_at, :timestamp
  end
end
