class User < ApplicationRecord
  has_many :pictures

  validates :uid, presence: true
  validates :password, presence: true
  has_secure_password
end
