class Account < ApplicationRecord
  has_secure_password

  has_many :sessions

  validates :email, presence: true, uniqueness: true
end
