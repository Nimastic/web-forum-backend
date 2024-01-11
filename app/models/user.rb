class User < ApplicationRecord
  has_many :posts
  has_many :comments
  has_secure_password

  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, uniqueness: { case_sensitive: false }, length: { maximum: 255 }

end
