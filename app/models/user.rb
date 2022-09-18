class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books, dependent: :destroy

         has_one_attached :image

# もし写真を持っていなかったら、unless、持ってたらその写真を表示
def get_profile_image(width, height)
  unless image.attached?
    file_path = Rails.root.join('app/assets/images/no_image.jpg')
    image.attach(io: File.open(file_path), filename: 'no_image.jpg', content_type: 'image/jpg')
  end
  image.variant(resize_to_limit: [width, height]).processed
end

end
