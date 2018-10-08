class CupboardsController < ApplicationController

  # before displaying pages/running action make sure user is admin otherwise redirect them and throw error
  before_action :admin_user,     only: [:destroy, :new, :create, :edit]

  # displaying all cupboards
  def index
    @cupboards = Cupboard.paginate(page: params[:page])
  end

  # showing cupboard information
  def show
    @cupboard = Cupboard.find(params[:id])
  end

  # new cupboard form page
  def new
    @cupboard = Cupboard.new
    @cupboard.items.build
  end

  # edit cupboard form page
  def edit
    @cupboard = Cupboard.find(params[:id])
  end

  # editing the cupboard
  def update
    @cupboard = Cupboard.find(params[:id])
    if @cupboard.update_attributes(cupboard_params)
      flash[:success] = "Cupboard updated"
      redirect_to @cupboard
    else
      render 'edit'
    end
  end

  # creating new cupboard
  def create
    @cupboard = Cupboard.new(cupboard_params)
    if @cupboard.save
      flash[:success] = "You created a new cupboard!"
      redirect_to @cupboard
    else
      render 'new'
    end
  end

  # deleting cupboard
  def destroy
    Cupboard.find(params[:id]).destroy
    flash[:success] = "Cupboard deleted"
    redirect_to cupboards_url
  end

  private

  # params that can be passed when creating a new cupboard (nested because you can create items inside a cupboard)
	def cupboard_params
  		params.require(:cupboard).permit(:name,  
    		:items_attributes => [:name, :borrowable, :item_quantity, :_destroy]
  		)
	end

  # confirms an admin user
  def admin_user
    redirect_to(cupboards_path) unless current_user.admin?
  end
end
