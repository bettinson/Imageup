class Image < ApplicationRecord
  validates :title, :path, presence: true
  # belongs_to :user
end
