# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  login           :string(255)
#  filial_id       :integer
#  cabinet         :string(255)
#  phone           :string(255)
#  admin           :boolean
#  password_digest :string(255)
#  remember_token  :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class User < ActiveRecord::Base
  attr_accessible :login, :password, :password_confirmation
  has_secure_password

  before_save { login.downcase! }
  before_save :create_remember_token

  validates :login,     presence: true, uniqueness: { case_sensitive: false }
  validates :password,  length: { minimum: 6 }
  validates :password_confirmation, presence: true

  private

    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end

end
