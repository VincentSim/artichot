class AddAttachmentPictureToEspaces < ActiveRecord::Migration
  def self.up
    change_table :espaces do |t|
      t.attachment :picture
    end
  end

  def self.down
    remove_attachment :espaces, :picture
  end
end
