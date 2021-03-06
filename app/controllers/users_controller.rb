class UsersController < ApplicationController
  
  # before displaying pages/running action make sure user is logged in, make sure user is the correct user and make sure user is admin otherwise redirect them and throw error
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
  before_action :correct_user,   only: [:update, :edit]
  before_action :admin_user,     only: [:destroy]

  # display all users
  def index
    @users = User.paginate(page: params[:page])
  end

  # display information about user
  def show
    @user = User.find(params[:id])

    @user_items_all = @user.user_items
  end

  # display form for new user
  def new
    @user = User.new
  end

  # display form for editing user
  def edit
    @user = User.find(params[:id])
  end

  # create new user
  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      render 'new'
    end
  end

  # updating user information
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  # deleting a user
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
  end

  private
 
    # params that can be passed when creating a user
    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end

    # confirms a logged in user
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end

    # confirms the correct user
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user) || current_user.admin?
    end

    # confirms an admin user
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end

end
