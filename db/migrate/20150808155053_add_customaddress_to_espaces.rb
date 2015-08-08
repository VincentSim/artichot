class AddCustomaddressToEspaces < ActiveRecord::Migration
  def change
    add_column :espaces, :street_number, :string
    add_column :espaces, :route, :string
    add_column :espaces, :locality, :string
    add_column :espaces, :administrative_area_level_1, :string
    add_column :espaces, :postal_code, :string
    add_column :espaces, :country, :string
  end
end
