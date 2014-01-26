# == Schema Information
#
# Table name: invites
#
#  id         :integer          not null, primary key
#  code       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Invite < ActiveRecord::Base
  attr_accessible :code

  VALID_CODE_EXP = /\A[a-z\d\-._]+\z/i

  # belongs_to :user

  validates :code, presence: true, format: { with: VALID_CODE_EXP }, uniqueness: { case_sensitive: false }


end
