class StaticPagesController < ApplicationController
  def home
  end

  def help
  end

  def about

  end

  def problemadd
    if signed_in?
      @problem = current_user.problems.build
      @feed_items = current_user.feed.paginate( page: params[:page], per_page: 10, )

    end

  end

end
