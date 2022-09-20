class Book < ApplicationRecord

  belongs_to :user

  # titleは空でない。

  validates :title, presence: true
    
  # bodyは空でないかつ文字数は、200文字まで
  validates :body, length: { maximum: 200 }, presence: true
    
end
