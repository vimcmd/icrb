# == Schema Information
#
# Table name: problems
#
#  id         :integer          not null, primary key
#  content    :string(255)
#  user_id    :integer
#  status_id  :integer          default(0), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Problem < ActiveRecord::Base
  attr_accessible :content, :admin_comment
  belongs_to :user

  validates :content, presence: true, length: { maximum: 80 }
  validates :admin_comment, length: { maximum: 80 }
  validates :user_id, presence: true

  default_scope order: 'problems.created_at DESC'
end
