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
  attr_accessible :login, :password, :password_confirmation, :reg_code
  attr_accessor :reg_code

  has_secure_password

  before_save { login.downcase! }
  before_save :create_remember_token

  VALID_LOGIN_EXP = /\A[a-z\d\-._]+\z/i

  validates :login, presence: true, format: { with: VALID_LOGIN_EXP }, uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 3 }
  validates :password_confirmation, presence: true
  validate  :validate_reg_code, :on => :create


  private
    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end

  protected
    def validate_reg_code
      if Invite.where("code = ?", @reg_code).empty?
        errors.add(:reg_code, I18n.t("activerecord.errors.models.user.attributes.reg_code.invalid"))
      end
    rescue ArgumentError
      errors.add :reg_code, "out of range"
    end

    # ------------
    #   invites_list = "SELECT * FROM invites WHERE reg_code = :reg_code"
    #   where("code IN (#{invites_list})  = :reg_code", reg_code: invite.code)
    # end
    #
    # def check_reg_code
    #  if !reg_code.nil?
    #    self.remember_token = SecureRandom.urlsafe_base64(20)
    #  else
    #    flash.now[:danger] = t(:wrong_reg_code)
    #    render 'new'
    # end


end
