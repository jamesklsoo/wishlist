class Wish < ApplicationRecord
  mount_uploader :picture, PictureUploader
end
