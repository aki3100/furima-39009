class ItemsController < ApplicationController
  before_action :authenticate_user!,        only: [:new, :edit, :destroy]
  before_action :set_item_params,           only: [:show, :edit, :update, :destroy]

  def index
    @items = Item.includes(:user).order('created_at DESC')
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
  end

  def edit
    same_parson
  end

  def update
    if @item.update(item_params)
      redirect_to item_path
    else
      render :edit
    end
  end

  def destroy
    if same_parson
      @item.destroy
      redirect_to root_path
    else
      redirect_to root_path
    end
  end

  private

  def item_params
    params.require(:item).permit(:image, :item_name, :item_info, :category_id, :item_status_id, :shopping_cost_id,
                                 :prefecture_id, :shopping_date_id, :price).merge(user_id: current_user.id)
  end

  def set_item_params
    @item = Item.find(params[:id])
  end

  def same_parson
    if @item.user_id == current_user.id && @item.order.nil?
    else
      redirect_to root_path
    end
  end
end
