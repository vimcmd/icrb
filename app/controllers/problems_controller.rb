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
      @problem.destroy
      redirect_to :back
      flash[:info] = t( :problem_cancel )
    rescue ActionController::RedirectBackError
      redirect_to root_path
    end
  end

  def add
    if signed_in?
      @problem = current_user.problems.build
      @feed_items = current_user.feed.paginate( page: params[:page], per_page: 10, )
    end
  end

  def all
    if current_user.admin?
      @problem = Problem.paginate( page: params[:page], per_page: 10, )
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
