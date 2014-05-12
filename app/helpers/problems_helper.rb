module ProblemsHelper
  def chart_data( start = 1.month.ago )
    # users_by_day              = User.total_grouped_by_day(start)
    problems_by_day             = Problem.total_grouped_by_day(start)
    # problems_new_by_day       = Problem.where(status_id: 0).total_grouped_by_day(start)
    # problems_completed_by_day = Problem.where(status_id: 1).total_grouped_by_day(start)
    # problems_canceled_by_day  = Problem.where(status_id: 2).total_grouped_by_day(start)
    (start.to_date..Date.today).map do |date|
      {
        created_at: date,
        # users_count: users_by_day[date].try(:first).try(:total_count) || 0,
        problems_total: problems_by_day[date].try(:first).try(:total_count) || 0,
        # problems_new: problems_new_by_day[date].try(:first).try(:total_count) || 0,
        # problems_completed: problems_completed_by_day[date].try(:first).try(:total_count) || 0,
        # problems_canceled: problems_new_by_day[date].try(:first).try(:total_count) || 0
       }
    end
  end

  def chart_heroku
    Time.zone = 'Ekaterinburg'
    (1.month.ago.to_date..Date.today).map do |date|
      {
        created_at: date.to_time_in_current_zone.strftime('%Y-%m-%d'),
        problems_total: Problem.where( "date(created_at) = ?", date ).try(:count) || 0,
        problems_comleted: Problem.where( "date(created_at) = ?", date ).where( "status_id != ?", '0' ).try(:count) || 0,
        users_registered: User.where( "date(created_at) = ?", date ).try(:count) || 0,
       }
    end
  end

  def problems_new_count
    Time.zone = 'Ekaterinburg'
    Problem.new_problems(1.week.ago) || 0
  end
end