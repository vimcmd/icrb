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
  attr_accessible :login, :password, :password_confirmation, :reg_code, :filial_id, :cabinet, :phone
  attr_accessor :reg_code

  has_many :problems, dependent: :destroy
  belongs_to :filial

  has_secure_password

  before_save { login.downcase! }
  before_save :create_remember_token

  VALID_LOGIN_EXP = /\A[a-z\d\-._]+\z/i

  validates :login, presence: true,
                    format: { with: VALID_LOGIN_EXP },
                    uniqueness: { case_sensitive: false }

  validates :password, length: { minimum: 5 }

  validates :password_confirmation, presence: true

  validate  :validate_reg_code, :on => :create



  def feed
    # temporal
    Problem.where("user_id = ?", id)
  end


  private
    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end

  protected
    def validate_reg_code
      # if Invite.exists? code: @regcode
      # errors.add ...
      # end
      if Invite.where("code = ?", @reg_code).empty?
        errors.add(:reg_code, I18n.t("activerecord.errors.models.user.attributes.reg_code.invalid"))
      end
    rescue ArgumentError
      errors.add :reg_code, "out of range"
    end


end
