class Image < ApplicationRecord
  validates :title, presence: true
  validate :is_accepted_file_format
  validates :path, presence: true
  # belongs_to :user

  def is_accepted_file_format
    if !path.nil?
      errors.add(:path, "isn't a valid file") unless [".gif",".jpg", ".png", ".jpeg"].include? File.extname(path).downcase
    end
  end
end
