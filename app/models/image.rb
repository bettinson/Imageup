class Image < ApplicationRecord
  validates :title, presence: true
  # validates :path, format: { with: /.*\\.(png|jpg|gif|bmp|jpeg)/, message: "Not a valid image" }
  validate :is_accepted_file_format
  validates :path, presence: true
  # belongs_to :user

  def is_accepted_file_format
    errors.add(:path, "isn't a valid file") unless [".jpg", ".png"].include? File.extname(path).downcase
  end
end
