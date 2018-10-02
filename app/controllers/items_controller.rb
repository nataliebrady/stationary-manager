class ItemsController < ApplicationController

  def index 
  	@items = Item.paginate(page: params[:page])
  end

  def new
  	@item = Item.new
  	@cupboards = Cupboard.all
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      flash[:success] = "You have created a new item!"
      redirect_to @item
    else
      render 'new'
    end
  end

  def order 
    @items = Item.all
    @item = Item.find(params[:id])
  end

  def show 
  	@item = Item.find(params[:id])
  end

  def edit
  	@item = Item.find(params[:id])
  	@cupboards = Cupboard.all
  end

  def update
    @item = Item.find(params[:id])
    if @item.update_attributes(item_params)
      flash[:success] = "Item updated"
      redirect_to @item
    else
      render 'edit'
    end
  end

  def destroy
    Item.find(params[:id]).destroy
    flash[:success] = "Item deleted"
    redirect_to items_url
  end

  private

  def item_params
  	params.require(:item).permit(:name, :cupboard_id, :borrowable, :item_quantity)
  end
end
