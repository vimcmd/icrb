# == Schema Information
#
# Table name: filials
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  address    :string(255)
#  phone      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Filial < ActiveRecord::Base
  attr_accessible :address, :name, :phone
  has_many :users

  validates :name, presence: true
  validates :address, presence: true
  validates :phone, presence: true

end
