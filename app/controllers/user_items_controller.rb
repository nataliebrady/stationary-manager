class UserItemsController < ApplicationController

  # before displaying pages/running action make sure user is admin and make sure user is logged in otherwise redirect them and throw error
  before_action :logged_in_user, only: [:index, :destroy]
  before_action :admin_user,     only: [:destroy]

  # displaying all orders
  def index  
    # Find the current users user_items id's and find those id's in the UserItem table 
    @user_items = current_user.user_items.pluck(:id).uniq
    @all_user_items = UserItem.where(id: @user_items)

    @user_items = UserItem.paginate(page: params[:page]) 
  end
  
  # showing order information
  def show
    @user_item = UserItem.find(params[:id])
  end

  def new
  	@user_item = UserItem.new
  end

  # creating a new order
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

  # deleting an order
  def destroy 
    UserItem.find(params[:id]).destroy
    flash[:success] = "Order history deleted"
    redirect_to user_items_url
  end

  # Returning action (sets the returned boolean to true and adds one back into the item quantity) then redirects to the users profile
  def returning
  	  @user_item = UserItem.find(params[:id])
      @user_item.update_attributes(returned: true)
      @user_item.item.update_columns(item_quantity: @user_item.item.item_quantity + 1)
      flash[:success] = "Item was returned"
      redirect_to current_user
  end

  private 

  # params that can be passed when creating an order
  def ordered_params
  	params.require(:user_item).permit(:item_id, :user_id)
  end

  # confirms an admin user
  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end

  # confirms a logged in user
  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = "Please log in."
      redirect_to login_url
    end
  end

end
