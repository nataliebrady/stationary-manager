class UserItemsController < ApplicationController
  before_action :logged_in_user, only: [:index, :destroy]
  before_action :admin_user,     only: [:destroy]

  def index  
    # Find the current users user_items id and find those id's in the UserItem table 
    @user_items = current_user.user_items.pluck(:id).uniq
    @all_user_items = UserItem.where(id: @user_items)

    @user_items = UserItem.paginate(page: params[:page]) 
  end
  
  def show
    @user_item = UserItem.find(params[:id])
  end

  def new
  	@user_item = UserItem.new
  end

  def create
    @user_item = current_user.user_items.create(ordered_params)
    if @user_item.save

      @user_item.item.update_columns(item_quantity: @user_item.item.item_quantity - 1)

      if @user_item.item.borrowable? 
      	@user_item.update_columns(returned: false)
      else 
      	@user_item.update_columns(returned: true)
      end

      flash[:success] = "You have ordered this item"
      redirect_to @user_item
  	else
  		redirect_to @user_item
  		flash[:danger] = "You could not order this item"
  	end
  end

  def destroy 
    UserItem.find(params[:id]).destroy
    flash[:success] = "User history deleted"
    redirect_to user_items_url
  end

  # Returning action (sets the returned boolean to true and updates the book status to 'available')
  def returning
  	  @user_item = UserItem.find(params[:id])
      @user_item.update_attributes(returned: true)
      @user_item.item.update_columns(item_quantity: @user_item.item.item_quantity + 1)
      redirect_to items_path
  end

  private 

  def ordered_params
  	params.require(:user_item).permit(:item_id, :user_id)
  end

  # Confirms an admin user.
  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end

  # Confirms a logged-in user.
  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = "Please log in."
      redirect_to login_url
    end
  end

end
