class ItemsController < ApplicationController
  before_action :move_to_sign_in, except: [:index, :show]
  before_action :item_setting, only: [:show, :edit, :update, :destroy]
  before_action :move_to_index, only: [:edit, :destroy]

  def index
    @items = Item.all.order('created_at DESC')
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.create(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    @item.update(item_params)
    if @item.save
      redirect_to item_path
    else
      render :edit
    end
  end

  def destroy
    @item.destroy
    redirect_to root_path
  end

  private

  def item_params
    params.require(:item).permit(:name, :price, :description, :category_id, :state_id, :shopping_charge_id, :prefecture_id,
                                 :delivery_time_id, :image).merge(user_id: current_user.id)
  end

  def move_to_sign_in
    unless user_signed_in?
      redirect_to new_user_session_path
    end
  end

  def item_setting
    @item = Item.find(params[:id])
  end

  def move_to_index
    if !(current_user.id == @item.user.id) || Order.exists?(item_id: @item.id)
      redirect_to action: :index
    end
  end

end
