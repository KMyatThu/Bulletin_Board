class User < ApplicationRecord
  validates :name, :profile, :address, :password, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }

  has_secure_password
  def self.types
    types = {
      '0' => 'Admin',
      '1' => 'User'
    }
  end
end
