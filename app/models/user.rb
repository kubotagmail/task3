class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books, dependent: :destroy

         has_one_attached :profile_image
         
 

  # nameの文字数は、2文字から20文字まで
  validates :name,length: { minimum: 2, maximum: 20 }, uniqueness: true
  # introductionの文字数は最大50文字まで
  validates :introduction,length: { maximum: 50 }
    
    
# もし写真を持っていなかったら、unless、持ってたらその写真を表示
def get_profile_image(width, height)
   unless profile_image.attached?
    file_path = Rails.root.join('app/assets/images/no_image.jpg')
     profile_image.attach(io: File.open(file_path), filename: 'no_image.jpg', content_type: 'image/jpg')
   end
    profile_image.variant(resize_to_limit: [width, height]).processed
end


end
