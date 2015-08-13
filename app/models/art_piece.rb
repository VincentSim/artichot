class ArtPiece < ActiveRecord::Base
  belongs_to :espace
  validates :espace, presence: true

  has_attached_file :picture,
    styles: {
      large: "1400x933>",
      medium: "640x480>",
      thumbnail: "70x40>"},
      default_url: "ateliershow.png"
  validates_attachment_content_type :picture, content_type: /\Aimage\/.*\z/
end
