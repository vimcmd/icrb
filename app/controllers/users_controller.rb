class UsersController < ApplicationController
  before_filter :signed_in_user, only: [:index, :edit, :update, :destroy]
  before_filter :correct_user,   only: [:edit, :update]
  before_filter :admin_user,     only: :destroy
  before_filter :prepare_filials

  def new
    @user = User.new
  end

  def index
    if current_user.admin?
      @users = User.paginate( page: params[:page], per_page: 10, :order => 'created_at DESC')
    else
      flash[:warning] = t( :user_restricted )
      redirect_to signin_path
    end
  end

  def show
    begin
      # add && current_user?
      if signed_in? #&& current_user? current_user.admin?
        @user = User.find(params[:id])
        @problems = @user.problems.paginate( page: params[:page], per_page: 10, )
      else
        flash[:warning] = t( :please_signin )
        redirect_to signin_path
      end
    rescue
      redirect_to root_path
    end
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      sign_in @user
      flash.now[:success] = t(:welcome)
      render :action => "edit"
      # redirect_to @user
    else
      render 'new'
    end
  end

  def edit
    @filial = Filial.find_by_id(@user.filial_id)

  end

  def update
    if @user.update_attributes(params[:user])
      flash[:success] = t(:profile_updated)
      sign_in @user
      redirect_to root_path
      # redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    User.find( params[:id] ).destroy
    flash[:danger] = t( :user_destroyed )
    redirect_to users_url
  end

  private

    def user_params
      params.require(:user).permit(:login, :password, :password_confirmation)
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end

    def admin_user
      redirect_to( root_path ) unless current_user.admin?
    end

    def prepare_filials
      @filials = Filial.order('name')
    end

end
