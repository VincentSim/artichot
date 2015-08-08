class AddCoordinatesToEspaces < ActiveRecord::Migration
  def change
    add_column :espaces, :latitude, :float
    add_column :espaces, :longitude, :float
  end
end
