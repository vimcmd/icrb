class ProblemsController < ApplicationController
  before_filter :signed_in_user
  before_filter :correct_user, only: :destroy
  #before_filter :check_profile

  def create
    begin
      @problem = current_user.problems.build(params[:problem])
      if @problem.save
        flash[:success] = t(:problem_send)
        # flash[:info] = t(:problem_send)
        redirect_to :back
      else
        @feed_items = []
        render 'problems/add'
      end
    rescue ActionController::RedirectBackError
      redirect_to root_path
    end
  end

  def destroy
    begin
      if @problem.status_id == 0
        @problem.destroy
        redirect_to :back
        flash[:info] = t( :problem_cancel )
      else
        redirect_to :back
        flash[:warning] = t( :problem_cant_cancel )
      end
    rescue ActionController::RedirectBackError
      redirect_to root_path
    end
  end

  def add
    if (!current_user.filial.blank? && !current_user.cabinet.blank?)
      if signed_in?
        @current_user_problems = Problem.where("user_id = ?", current_user.id).paginate( page: params[:page], per_page: 10, )
        @problem = current_user.problems.build
        @feed_items = current_user.feed.paginate( page: params[:page], per_page: 10, )
      end
    else
        redirect_to edit_user_path(current_user)
        # redirect_to controller: 'users', action: 'edit', id: current_user.id
        flash[:warning] = t( :user_profile_please_fill )
    end
  end

  def all
    if current_user.admin?
      @problem_new = Problem.where("status_id = ?  OR status_id = ?", 0, 3).paginate( page: params[:page], per_page: 5, )
      @problem_completed = Problem.where("status_id = ? OR status_id = ?", 1, 2).paginate( page: params[:page], per_page: 5, )
    else
      flash[:warning] = t( :user_restricted )
      redirect_to signin_path
    end
  end

  def statistics
    #chart data places in problems_helper#chart_data
    if current_user.admin?

    else
      flash[:warning] = t( :user_restricted )
      redirect_to signin_path
    end

  end

  private

    def correct_user
      @problem = current_user.problems.find_by_id(params[:id])
      redirect_to root_url if @problem.nil?
    end

end
