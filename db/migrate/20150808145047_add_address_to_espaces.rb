class AddAddressToEspaces < ActiveRecord::Migration
  def change
    add_column :espaces, :address, :string
  end
end
