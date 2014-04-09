class ProblemsController < ApplicationController
  before_filter :signed_in_user
  before_filter :correct_user, only: :destroy
  #before_filter :check_profile

  def create
    @problem = current_user.problems.build(params[:problem])
    if @problem.save
      flash[:success] = t(:problem_send)
      # flash[:info] = t(:problem_send)
      redirect_to problemadd_path
    else
      @feed_items = []
      render 'static_pages/problemadd'
    end
  end

  def destroy
    @problem.destroy
    redirect_back_or root_url
  end

  private

    def correct_user
      @problem = current_user.problems.find_by_id(params[:id])
      redirect_to root_url if @problem.nil?
    end

end
