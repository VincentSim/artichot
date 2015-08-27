class AddDescriptionToArtPieces < ActiveRecord::Migration
  def change
    add_column :art_pieces, :description, :text
  end
end
