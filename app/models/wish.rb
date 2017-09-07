class Wish < ApplicationRecord
  belongs_to :user, :optional => true
  mount_uploader :picture, PictureUploader

  def self.search(search)
    search = search.downcase
    where("LOWER(description) LIKE ?", "%#{search}%")
  end
end
