class User < ApplicationRecord
  belongs_to :created_user, class_name: "User", foreign_key: "create_user_id"
  belongs_to :updated_user, class_name: "User", foreign_key: "updated_user_id"

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
