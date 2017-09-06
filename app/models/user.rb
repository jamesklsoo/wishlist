class User < ApplicationRecord
  has_secure_password

  has_many :authentication, :dependent => destroy

  validates_presence_of :fullname
  validates_presence_of :email
  validates :password, presence: true, length: { in: 6..20}
  validates :valid_email
  before_create :valid_email

  has_many :wishes

  def valid_email
    unless self.email =~ /\w+@\w+\.\w{2,}/
      errors.add(:email, "is not valid.")
    end
  end

  def self.create_with_auth_and_hash(authentication, auth_hash)
    create! do |user|
      user.fullname = auth_hash["extra"]["raw_info"]["name"]
      user.email = auth_hash["extra"]["raw_info"]["email"]
      user.authentications << (authentication)
      user.password = SecureRandom.hex(7)
    end
  end
