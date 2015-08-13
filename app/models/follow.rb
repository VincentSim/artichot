class Follow < ActiveRecord::Base
  belongs_to :user
  belongs_to :espace

  validates :user_id, :espace_id, presence: true

  validates :user_id, :uniqueness => {:scope => :espace_id}
end
