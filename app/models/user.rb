class User < ApplicationRecord
  before_create { generate_token(:auth_token) }

  belongs_to :created_user, class_name: "User", foreign_key: "create_user_id"
  belongs_to :updated_user, class_name: "User", foreign_key: "updated_user_id"

  validates :name, :profile, presence: true
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }

  has_secure_password

  def send_password_reset
    generate_token(:password_reset_token)
    self.password_reset_sent_at = Time.zone.now
    save!
    UserMailer.password_reset(self).deliver_now
  end

  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])
  end
end
