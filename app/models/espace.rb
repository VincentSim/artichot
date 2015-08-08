class Espace < ActiveRecord::Base
  belongs_to :user
  geocoded_by :address
  after_validation :geocode, if: :address_changed?


  EN_CATEGORY =  ["architecture", "ceramic", "craftwork", "design", "designer", "engraving", "glasswork", "metalwork", "new materials", "new media", "painting", "photography", "sculpture", "video"]
  FR_CATEGORY = [["architecture"],
 ["artisanat", "craftwork"],
 ["céramique", "ceramic"],
 ["design"],
 ["ferronnerie", "metalwork"],
 ["graphiste", "designer"],
 ["gravures", "engraving"],
 ["nouveaux matériaux", "new materials"],
 ["nouveaux médias", "new media"],
 ["peinture", "painting"],
 ["photographie", "photography"],
 ["sculpture"],
 ["verrerie", "glasswork"],
 ["vidéo", "video"]]

end
