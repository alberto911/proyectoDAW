class CreateEmployees < ActiveRecord::Migration
  def change
    create_table :employees do |t|
      t.boolean :is_admin, default: false
    end
  end
end
