class SessionsController < ApplicationController

  def new
  end

  def create
    sign_out
    user = User.find_by_login(params[:session][:login].downcase)
    if user && user.authenticate(params[:session][:password])
      sign_in user
      # redirect_back_or user
      redirect_to root_path
    else
      flash.now[:danger] = t(:wrong_login_password)
      render 'new'
    end
  end

  def destroy
    sign_out
    redirect_to root_url
  end


end
