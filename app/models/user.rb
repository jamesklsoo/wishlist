class User < ApplicationRecord
  include BCrypt
  has_secure_password
  has_many :authentications, :dependent => :destroy

  validates_presence_of :fullname
  validates_presence_of :email
  validates :password, presence: true, length: { in: 6..20}
  # validates :valid_email, presence: true


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

  def fb_token
    x = self.authentications.where(:provider => :facebook).first
    return x.token unless x.nil?
  end

  def name
    fullname
  end
end
