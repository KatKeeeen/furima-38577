class OrdersController < ApplicationController
  before_action :item_setting
  before_action :move_to_index

  def index
    @order_destination = OrderDestination.new
  end

  def create
    @order_destination = OrderDestination.new(order_params)
    if @order_destination.valid?
      Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
      Payjp::Charge.create(
        amount: @item.price,
        card: order_params[:token],
        currency: 'jpy'
      )
      @order_destination.save
      return redirect_to root_path
    else
      render :index
    end
  end

  private

  def item_setting
    @item = Item.find(params[:item_id])
  end

  def move_to_index
    if user_signed_in?
      if Order.exists?(item_id: @item.id) || current_user.id == @item.user.id
        redirect_to root_path
      end
    else
      redirect_to root_path
    end
  end

  def order_params
    params.require(:order_destination).permit(:post_code, :prefecture_id, :city, :address, :building_name, :phone_number).merge(user_id: current_user.id, item_id: params[:item_id], token: params[:token])
  end

end
