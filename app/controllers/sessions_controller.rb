class SessionsController < ApplicationController

  # stop user from trying to log in when they're already logged in (throw error if they try)
  before_action :logged_in_cannot_login, only: [:create, :new]

  def new
  end

  # creating a new session when logging in
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in user
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      redirect_back_or user
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end

  # destroying session when logging out
  def destroy
    log_out if logged_in?
    redirect_to root_url
  end

  private 

  # stop user from trying to log in when they're already logged in (throw error if they try)
  def logged_in_cannot_login
    if(logged_in?)
      flash[:danger] = "You are already logged in."
      redirect_to root_url
    end
  end
end
