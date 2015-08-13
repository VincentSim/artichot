class Espace < ActiveRecord::Base
  belongs_to :user
  has_many :art_pieces
  geocoded_by :address
  after_validation :geocode, if: :address_changed?


  EN_CATEGORY =   ["architecture", "ceramic", "craftwork", "design", "engraving", "glasswork", "metalwork", "new materials", "new media", "painting", "photography", "sculpture", "video", "woodwork"]
  FR_CATEGORY = ["architecture", ["artisanat", "craftwork"], ["céramique", "ceramic"], "design", ["ébénisterie" , "woodwork"],
["ferronnerie", "metalwork"],
 ["gravures", "engraving"],
 ["nouveaux matériaux", "new materials"],
 ["nouveaux médias", "new media"],
 ["peinture", "painting"],
 ["photographie", "photography"],
 ["sculpture","sculpture"],
 ["verrerie", "glasswork"],
 ["vidéo", "video"]]

  validates :name, presence: true
  validates :user, presence: true

 has_attached_file :picture,
    styles: {
      large: "1400x933>",
      medium: "350x233>",
      thumbnail: "70x40>"},
      default_url: "ateliershow.png"
  validates_attachment_content_type :picture, content_type: /\Aimage\/.*\z/

end
