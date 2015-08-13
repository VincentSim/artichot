class AddAttachmentPictureToArtPieces < ActiveRecord::Migration
  def self.up
    change_table :art_pieces do |t|
      t.attachment :picture
    end
  end

  def self.down
    remove_attachment :art_pieces, :picture
  end
end
