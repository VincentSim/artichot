class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :espaces, dependent: :destroy
  has_many :follows, dependent: :destroy
  has_many :likes, dependent: :destroy

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true
  validates :encrypted_password, presence: true

  has_attached_file :picture,
    styles: { medium: "300x300#", thumb: "100x100#" }

  validates_attachment_content_type :picture,
    content_type: /\Aimage\/.*\z/

  def put_picture(size)
    if self.picture.present?
      self.picture(size)
    else
      "Artichautseul.jpg"
    end
  end

end
