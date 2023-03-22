class OrdersController < ApplicationController
  before_action :authenticate_user!,        only: [:index, :create]
  before_action :set_item_params,           only: [:index, :create]
  before_action :correct_order,             only: [:index, :create]

  def index
    @order_payment = OrderPayment.new
  end

  def create
    @order_payment = OrderPayment.new(order_params)
    if @order_payment.valid?
      payjp_params
      @order_payment.save
      redirect_to root_path
    else
      render :index
    end
  end

  private

  def set_item_params
    @item = Item.find(params[:item_id])
  end

  def correct_order
    return unless @item.user_id == current_user.id || @item.order.present?

    redirect_to root_path
  end

  def order_params
    params.require(:order_payment).permit(:postal_code, :prefecture_id, :city, :addresses, :building, :phone_number).merge(
      user_id: current_user.id, item_id: params[:item_id], token: params[:token]
    )
  end

  def payjp_params
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(
      amount: @item.price,        # 商品の値段
      card: order_params[:token], # カードトークン
      currency: 'jpy'             # 通貨の種類（日本円）
    )
  end
end
