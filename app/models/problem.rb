# == Schema Information
#
# Table name: problems
#
#  id            :integer          not null, primary key
#  content       :string(255)
#  admin_comment :string(255)
#  user_id       :integer
#  status_id     :integer          default(0), not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Problem < ActiveRecord::Base
  attr_accessible :content, :admin_comment, :status_id
  belongs_to :user

  validates :content, presence: true, length: { maximum: 250 }
  validates :admin_comment, length: { maximum: 80 }
  validates :user_id, presence: true

  default_scope order: 'problems.created_at DESC'

  # method for chart data in statistics
  def self.total_grouped_by_day(start)
    problems = where(created_at: start.beginning_of_day..Time.zone.now)
    problems = problems.group("date(created_at)")
    problems = problems.select("created_at, count(created_at) as total_count, status_id")
    problems.group_by { |p| p.created_at.to_date }
  end

  #sidebar new problems count in span
  def self.new_problems(start)
    problems = where(created_at: start.beginning_of_day..Time.zone.now)
    problems = problems.where("status_id = ?", 0).count
    # problems = problems.group("id")
    # problems = problems.select("id, status_id")
    # problems.group_by { |p| p.id }.count
  end

end
