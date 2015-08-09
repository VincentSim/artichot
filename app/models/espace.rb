class Espace < ActiveRecord::Base
  belongs_to :user
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

end
