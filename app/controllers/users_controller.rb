class UsersController < ApplicationController
  before_filter :signed_in_user, only: [:index, :edit, :update, :destroy]
  before_filter :correct_user,   only: [:edit, :update]
  before_filter :admin_user,     only: :destroy
  before_filter :prepare_filials

  def new
    sign_out
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
      if current_user.admin?
        @user = User.find(params[:id])
        @problems = @user.problems.paginate( page: params[:page], per_page: 10, )
        @current_user_problems = Problem.where( "user_id = ?", @user.id ).paginate( page: params[:page], per_page: 5, )
      else
        flash[:warning] = t( :please_signin )
        redirect_to signin_path
      end
    rescue
      redirect_to :back
    end
  end

  def create
    sign_out
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
    params[:user].delete :login

    # if (params[:password] && params[:password_confirmation]).blank?
    #   params[:user].delete :password
    #   params[:user].delete :password_confirmation
    # end

    if @user.update_attributes(params[:user])
      flash[:success] = t(:profile_updated)
      sign_in @user
      render 'edit'
      # redirect_to :back
      # redirect_to @user
    else
      render 'edit'
      # redirect_to :back
    end
  end

  def destroy
    User.find( params[:id] ).destroy
    flash[:danger] = t( :user_destroyed )
    redirect_to :back
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
