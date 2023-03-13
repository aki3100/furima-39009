require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = Factory.build(:item)
  end
  describe '商品出品機能' do
    context '商品が出品できる場合' do

      it 'すべての情報が存在すれば登録できる' do
        expect(@item).to be_valid
      end
      it "カテゴリーが「---」以外であれば登録できる" do
        @item.item_category_id = 1
        expect(@item).to be_valid
      end
      it '商品の状態が「---」以外であれば登録できる' do
        @item.item_sales_status_id = 1
        expect(@item).to be_valid
      end
      it '配送料の負担が「---」以外であれば登録できる' do
        @item.item_shipping_fee_status_id = 1
        expect(@item).to be_valid
      end
      it '発送元の地域が「---」以外であれば登録できる' do
        @item.item_prefecture_id = 1
        expect(@item).to be_valid
      end
      it '発送までの日数が「---」以外であれば登録できる' do
        @item.item_scheduled_delivery_id = 1
        expect(@item).to be_valid
      end
      it '価格が半角数字で￥300~￥9,999,999以内であれば登録できる' do
        @item.item_price = 300
        expect(@item).to be_valid
      end
    end


    context '商品が出品できない場合' do

      it '' do
      end
      it '' do
      end
      it '' do
      end
      it '' do
      end
      it '' do
      end
    end
  end
end
