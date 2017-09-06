require 'bcrypt'
class User < ApplicationRecord
  include BCrypt
  has_secure_password

  has_many :authentications, :dependent => :destroy

  validates_presence_of :fullname
  validates_presence_of :email
  validates :password, presence: true, length: { in: 6..20}
  validates :valid_email, presence: true
  before_create :valid_email

  has_many :wishes

  def valid_email
    unless self.email =~ /\w+@\w+\.\w{2,}/
      errors.add(:email, "is not valid.")
    end
  end

  def password
    @password ||= Password.new(password_hash)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end

  def name
    fullname
  end
end
