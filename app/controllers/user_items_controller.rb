class UserItemsController < ApplicationController

  def index  
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

  def order 
    @items = Item.all
    @item = Item.find(params[:id])
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

end
