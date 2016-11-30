class AddRecibidoToTransfers < ActiveRecord::Migration
  def change
    add_column :transfers, :recibido, :bool, default: false
  end
end
