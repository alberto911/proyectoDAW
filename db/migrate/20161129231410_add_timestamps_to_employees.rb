class AddTimestampsToEmployees < ActiveRecord::Migration
  def change
    add_column :employees, :created_at, :timestamp
    add_column :employees, :updated_at, :timestamp
  end
end
