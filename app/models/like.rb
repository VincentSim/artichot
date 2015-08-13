class Like < ActiveRecord::Base
  belongs_to :user
  belongs_to :art_piece

  validates :user_id, :espace_id, presence: true

  validates :user_id, :uniqueness => {:scope => :art_piece_id}
end
