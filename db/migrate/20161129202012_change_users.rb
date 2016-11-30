class ChangeUsers < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.references :userable, polymorphic: true, index: true
    end
  end
end
