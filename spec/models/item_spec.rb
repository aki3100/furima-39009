require "rails_helper"

RSpec.describe Item, type: :model do
  before do
    @item = Factory.build(:item)
  end
  describe "商品出品機能" do
    context "商品が出品できる場合" do
      it "すべての情報が存在すれば登録できる" do
        expect(@item).to be_valid
      end
      it "カテゴリーが「---」以外であれば登録できる" do
        @item.item_category_id = 1
        expect(@item).to be_valid
      end
      it "商品の状態が「---」以外であれば登録できる" do
        @item.item_sales_status_id = 1
        expect(@item).to be_valid
      end
      it "配送料の負担が「---」以外であれば登録できる" do
        @item.item_shipping_fee_status_id = 1
        expect(@item).to be_valid
      end
      it "発送元の地域が「---」以外であれば登録できる" do
        @item.item_prefecture_id = 1
        expect(@item).to be_valid
      end
      it "発送までの日数が「---」以外であれば登録できる" do
        @item.item_scheduled_delivery_id = 1
        expect(@item).to be_valid
      end
      it "価格が半角数字で￥300~￥9,999,999以内であれば登録できる" do
        @item.item_price = 300
        expect(@item).to be_valid
      end
    end

    context "商品が出品できない場合" do
      it "ユーザー登録をしていないと登録できない"do
        @item.user_id = ""
        @item.valid?
        expect(@item.errors.full_messages).to include "user must exist"
      end

      it "画像が1枚ないと登録できない"do
        @item.image = ""
        @item.valid?
        expect(@item.errors.full_messages).to include "Image can't be blank"
      end
      it "商品名が空白だと登録できない" do
        @item.item_name = ""
        @item.valid?
        expect(@item.errors.full_messages).to include "Item name can't be blank"
      end
      it "商品の説明が空白だと登録できない" do
        @item.item_info = ""
        @item.valid?
        expect(@item.errors.full_messages).to include "Item info can't be blank"
      end
      it "商品のカテゴリーが「---」だと登録できない" do
        @item.item_category_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include "Item category must be other then: 0"
      end
      it "商品の状態が「---」だと登録できない" do
        @item.item_sales_status_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include "Item sales status must be other then: 0"
      end
      it "配送料の負担が「---」だと登録できない" do
        @item.item_shipping_fee_status_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include "Item shipping fee status must be other then: 0"
      end
      it "発送元の地域が「---」だと登録できない" do
        @item.item_prefecture_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include "Item prefecture must be other then: 0"
      end
      it "発送までの日数が「---」だと登録できない" do
        @item.item_scheduled_delivery_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include "Item scheduled delivery must be other then: 0"
      end
      it "価格が空白だと登録できない" do
        @item.item_price = ""
        @item.valid?
        expect(@item.errors.full_messages).to include "Item price can't be blank"
      end
      it "販売価格が「￥299」以下だと登録できない" do
        @item.item_price = 299
        @item.valid?
        expect(@item.errors.full_messages).to include "Item price must be greater than or equal to 300"
      end
      it "販売価格が「￥10,000,000」以上だと登録できない" do
        @item.item_price = 10_000_000
        @item.valid?
        expect(@item.errors.full_messages).to include "Item price must be less than or equal_to: 9999999"
      end
    end
  end
end
