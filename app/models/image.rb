class Image < ApplicationRecord
  validates :title, presence: true
  # validates :path, format: { with: /.*\\.(png|jpg|gif|bmp|jpeg)/, message: "Not a valid image" }
  validates :path, presence: true
  # belongs_to :user
end
