require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end
  describe '商品出品機能' do
    context '商品が出品できる場合' do
      it 'すべての情報が存在すれば登録できる' do
        expect(@item).to be_valid
      end
      it 'カテゴリーが「---」以外であれば登録できる' do
        @item.category_id = 1
        expect(@item).to be_valid
      end
      it '商品の状態が「---」以外であれば登録できる' do
        @item.item_status_id = 1
        expect(@item).to be_valid
      end
      it '配送料の負担が「---」以外であれば登録できる' do
        @item.shopping_cost_id = 1
        expect(@item).to be_valid
      end
      it '発送元の地域が「---」以外であれば登録できる' do
        @item.prefecture_id = 1
        expect(@item).to be_valid
      end
      it '発送までの日数が「---」以外であれば登録できる' do
        @item.shopping_date_id = 1
        expect(@item).to be_valid
      end
      it '価格が半角数字で￥300~￥9,999,999以内であれば登録できる' do
        @item.price = 300
        expect(@item).to be_valid
      end
    end

    context '商品が出品できない場合' do
      it '画像が1枚ないと登録できない' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include "Image can't be blank"
      end
      it '商品名が空白だと登録できない' do
        @item.item_name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include "Item name can't be blank"
      end
      it '商品の説明が空白だと登録できない' do
        @item.item_info = ''
        @item.valid?
        expect(@item.errors.full_messages).to include "Item info can't be blank"
      end
      it '商品のカテゴリーが「---」だと登録できない' do
        @item.category_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include "Category can't be blank"
      end
      it '商品の状態が「---」だと登録できない' do
        @item.item_status_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include "Item status can't be blank"
      end
      it '配送料の負担が「---」だと登録できない' do
        @item.shopping_cost_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include "Shopping cost can't be blank"
      end
      it '発送元の地域が「---」だと登録できない' do
        @item.prefecture_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include "Prefecture can't be blank"
      end
      it '発送までの日数が「---」だと登録できない' do
        @item.shopping_date_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include "Shopping date can't be blank"
      end
      it '価格が空白だと登録できない' do
        @item.price = ''
        @item.valid?
        expect(@item.errors.full_messages).to include 'Price is not a number'
      end
      it '販売価格の数字が全角だと登録できない' do
        @item.price = '３００'
        @item.valid?
        expect(@item.errors.full_messages).to include 'Price is not a number'
      end
      it '販売価格が「￥299」以下だと登録できない' do
        @item.price = 299
        @item.valid?
        expect(@item.errors.full_messages).to include 'Price must be greater than or equal to 300'
      end
      it '販売価格が「￥10,000,000」以上だと登録できない' do
        @item.price = 10_000_000
        @item.valid?
        expect(@item.errors.full_messages).to include 'Price must be less than or equal to 9999999'
      end
      it 'ユーザーが紐付いていなければ投稿できない' do
        @item.user = nil
        @item.valid?
        expect(@item.errors.full_messages).to include 'User must exist'
      end
    end
  end
end
