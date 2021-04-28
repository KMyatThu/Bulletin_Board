class User < ApplicationRecord
  validates :name, :profile, :address, presence: true
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }

  has_secure_password
  def self.types
    types = {
      '0' => 'Admin',
      '1' => 'User'
    }
  end
end
