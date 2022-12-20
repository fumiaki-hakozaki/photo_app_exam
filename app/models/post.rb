class Post < ApplicationRecord
  belongs_to :user
  validates :title,presence: true
  validates :title, length: { minimum: 1, maximum:75}
  
  mount_uploader :image, ImageUploader
end
