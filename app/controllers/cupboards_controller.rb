class CupboardsController < ApplicationController

  def index
    @cupboards = Cupboard.paginate(page: params[:page])
  end

  def show
    @cupboard = Cupboard.find(params[:id])
  end

  def new
    @cupboard = Cupboard.new
    @cupboard.items.build
  end

  def edit
    @cupboard = Cupboard.find(params[:id])
  end

  def update
    @cupboard = Cupboard.find(params[:id])
    if @cupboard.update_attributes(cupboard_params)
      flash[:success] = "Cupboard updated"
      redirect_to @cupboard
    else
      render 'edit'
    end
  end

  def create
    @cupboard = Cupboard.new(cupboard_params)
    if @cupboard.save!
      flash[:success] = "You created a new cupboard!"
      redirect_to @cupboard
    else
      render 'new'
    end
  end

  def destroy
    Cupboard.find(params[:id]).destroy
    flash[:success] = "Cupboard deleted"
    redirect_to cupboards_url
  end

    private

	def cupboard_params
  		params.require(:cupboard).permit(:name,  
    		:items_attributes => [:name, :borrowable, :item_quantity, :_destroy]
  		)
	end
end
