class CreateArtPieces < ActiveRecord::Migration
  def change
    create_table :art_pieces do |t|
      t.references :espace, index: true
      t.string :title

      t.timestamps
    end
  end
end
