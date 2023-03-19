require 'rails_helper'

RSpec.describe OrderPayment, type: :model do
  before do
    @order_payment = FactoryBot.build(:order_payment)
  end

  describe '商品購入機能' do
    context '商品が購入できる場合' do
      it 'すべての情報が存在すれば登録できる' do
        expect(@order_payment).to be_valid
      end
      it '建物名がなくても他の情報が入っていれば登録できる' do
        @order_payment.building = ""
        expect(@order_payment).to be_valid
      end
      it '電話番号が11桁以内の数字であれば登録できる' do
        @order_payment.building = "0123456789"
        expect(@order_payment).to be_valid
      end
    end

    context '商品が購入できない場合' do
      it '郵便番号が空欄の場合登録できない' do
        @order_payment.postal_code = ""
        @order_payment.valid?
        expect(@order_payment.errors.full_messages).to include 'Postal codeを半角数字で入力してください'
      end
      it '郵便番号は全角数字では登録できない' do
        @order_payment.postal_code = "９９９－９９９９"
        @order_payment.valid?
        expect(@order_payment.errors.full_messages).to include 'Postal codeを半角数字で入力してください'
      end
      it '郵便番号に半角英字が含まれると登録できない' do
        @order_payment.postal_code = "a11-1111"
        @order_payment.valid?
        expect(@order_payment.errors.full_messages).to include 'Postal codeを半角数字で入力してください'
      end
      it '郵便番号に全角英字が含まれると登録できない' do
        @order_payment.postal_code = "Ａ11-1111"
        @order_payment.valid?
        expect(@order_payment.errors.full_messages).to include 'Postal codeを半角数字で入力してください'
      end
      it '発送元の地域が「---」だと登録できない' do
        @order_payment.prefecture_id = 0
        @order_payment.valid?
        expect(@order_payment.errors.full_messages).to include 'Prefecture「---」以外を選んでください'
      end
      it '市区町村が空欄だと登録できない' do
        @order_payment.city = ""
        @order_payment.valid?
        expect(@order_payment.errors.full_messages).to include 'Cityを入力してください'
      end
      it '番地が空欄だと登録できない' do
        @order_payment.addresses = ""
        @order_payment.valid?
        expect(@order_payment.errors.full_messages).to include 'Addressesを入力してください'
      end
      it '電話番号は半角数字でないと登録できない' do
        @order_payment.phone_number = "０123456789"
        @order_payment.valid?
        expect(@order_payment.errors.full_messages).to include 'Phone numberを半角数字（11桁以内）で入力してください'
      end
      it '電話番号に「-」が入っているとと登録できない' do
        @order_payment.phone_number = "012-34567890"
        @order_payment.valid?
        expect(@order_payment.errors.full_messages).to include 'Phone numberを半角数字（11桁以内）で入力してください'
      end
      it 'トークンが空欄だと登録できない' do
        @order_payment.token = ""
        @order_payment.valid?
        expect(@order_payment.errors.full_messages).to include 'Tokenを入力してください'
      end
      it 'user_idが空だと保存できない' do
        @order_payment.user_id = ""
        @order_payment.valid?
        expect(@order_payment.errors.full_messages).to include"Userを入力してください"
      end
      it 'item_idが空だと保存できない' do
        @order_payment.item_id = ""
        @order_payment.valid?
        expect(@order_payment.errors.full_messages).to include"Itemを入力してください"
      end
    end

  end
end