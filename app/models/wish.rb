class Wish < ApplicationRecord
  belongs_to :user, :optional => true
  mount_uploader :picture, PictureUploader

  def self.search(search)
    if search
      where("LOWER(name) LIKE ?", "%#{search}%").order('id DESC')
    else
      order('id DESC')
    end
  end
end
