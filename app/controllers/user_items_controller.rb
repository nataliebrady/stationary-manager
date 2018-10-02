class UserItemsController < ApplicationController

  def index
    @user_items = UserItem.paginate(page: params[:page])   
  end
  
  def show
    @user_item = UserItem.find(params[:id])
    @item = Item.find(params[:id])
  end

  def new
  	@user_item = UserItem.new
  end

  def order 
    @items = Item.all
    @item = Item.find(params[:id])
  end

  def create
    @user_item = current_user.user_items.create(ordered_params)
    if @user_item.save
      flash[:success] = "You have ordered this item"
      redirect_to @user_item
  	else
  		redirect_to @user_item
  		flash[:danger] = "You could not order this item"
  	end
  end

  private 

  def ordered_params
  	params.require(:user_item).permit(:item_id, :user_id)
  end

end
