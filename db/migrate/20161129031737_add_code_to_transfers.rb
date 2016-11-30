class AddCodeToTransfers < ActiveRecord::Migration
  def change
    add_column :transfers, :code, :string
  end
end
