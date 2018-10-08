class ItemsController < ApplicationController

  # before displaying pages/running action make sure item is available, make sure user doesn't have a fine and make sure user is admin otherwise redirect them and throw error
  before_action :item_not_available, only: [:order]
  before_action :fined, only: [:order]
  before_action :admin_user,     only: [:destroy, :new, :create, :edit]

  # display all items (paginate them) and also find all current users orders
  def index 
  	@items = Item.paginate(page: params[:page])

    @user_items = current_user.user_items.pluck(:id).uniq
    @all_user_items = UserItem.where(id: @user_items)
  end


  # the new item form page
  def new
  	@item = Item.new
  	@cupboards = Cupboard.all
  end

  # creating the item
  def create
    @cupboards = Cupboard.all
    @item = Item.new(item_params)
    if @item.save
      flash[:success] = "You have created a new item!"
      redirect_to @item
    else
      render 'new'
    end
  end

  # finding out whether the current user has a fine or not
  def fined 
    @item = Item.find(params[:id])
    # finding all the users orders 
    @user_items = current_user.user_items.pluck(:id).uniq
    @all_user_items = UserItem.where(id: @user_items)

    if(@item.borrowable?)
     # if the users order created_at date is less than the date today - 2 and it hasn't been returned then display an error
     if(@all_user_items.where('created_at < ? and returned = ?', DateTime.now-2.days, false).present?)
      flash[:danger] = "Item cannot be borrowed, you currently have a fine"
      redirect_to items_path
     else

     end
   else
   end
  end

  # where you submit the order
  def order 
    @items = Item.all
    @item = Item.find(params[:id])
  end

  # showing the items information
  def show 
  	@item = Item.find(params[:id])
  end

  # the edit item form page
  def edit
  	@item = Item.find(params[:id])
  	@cupboards = Cupboard.all
  end

  # editing the item
  def update
    @item = Item.find(params[:id])
    if @item.update_attributes(item_params)
      flash[:success] = "Item updated"
      redirect_to @item
    else
      render 'edit'
    end
  end

  # deleting the item
  def destroy
    Item.find(params[:id]).destroy
    flash[:success] = "Item deleted"
    redirect_to items_url
  end

  private

  # parameters that can be passed through when item created
  def item_params
  	params.require(:item).permit(:name, :cupboard_id, :borrowable, :item_quantity)
  end

  # checking if the item quantity is 0 or not and throwing error if it is
  def item_not_available
    @item = Item.find(params[:id])
    if(@item.item_quantity == 0) 
      flash[:danger] = "Item cannot be borrowed or used - none available"
      redirect_to items_path
    end
  end

  # confirms an admin user
  def admin_user
    redirect_to(items_path) unless current_user.admin?
  end
end
