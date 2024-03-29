require 'rails_helper'

RSpec.describe OrderPayment, type: :model do
  describe '商品購入機能' do
    before do
      user = FactoryBot.create(:user)
      item = FactoryBot.create(:item)
      @order_payment = FactoryBot.build(:order_payment, user_id: user.id, item_id: item.id)
      sleep(0.5)
    end

    context '商品が購入できる場合' do
      it 'すべての情報が存在すれば登録できる' do
        expect(@order_payment).to be_valid
      end
      it '建物名がなくても他の情報が入っていれば登録できる' do
        @order_payment.building = ''
        expect(@order_payment).to be_valid
      end
      it '電話番号が10桁でも登録できる' do
        @order_payment.building = '0123456789'
        expect(@order_payment).to be_valid
      end
    end

    context '商品が購入できない場合' do
      it '郵便番号が空欄の場合登録できない' do
        @order_payment.postal_code = ''
        @order_payment.valid?
        expect(@order_payment.errors.full_messages).to include "Postal code can't be blank"
      end
      it '郵便番号は全角数字では登録できない' do
        @order_payment.postal_code = '９９９－９９９９'
        @order_payment.valid?
        expect(@order_payment.errors.full_messages).to include "Postal code can't be blank"
      end
      it '郵便番号に半角英字が含まれると登録できない' do
        @order_payment.postal_code = 'a11-1111'
        @order_payment.valid?
        expect(@order_payment.errors.full_messages).to include "Postal code can't be blank"
      end
      it '郵便番号に全角英字が含まれると登録できない' do
        @order_payment.postal_code = 'Ａ111111'
        @order_payment.valid?
        expect(@order_payment.errors.full_messages).to include "Postal code can't be blank"
      end
      it '郵便番号に「-」がないと登録できない' do
        @order_payment.postal_code = '1111111'
        @order_payment.valid?
        expect(@order_payment.errors.full_messages).to include "Postal code can't be blank"
      end
      it '発送元の地域が「---」だと登録できない' do
        @order_payment.prefecture_id = 0
        @order_payment.valid?
        expect(@order_payment.errors.full_messages).to include 'Prefecture Please choose other than 「---」'
      end
      it '市区町村が空欄だと登録できない' do
        @order_payment.city = ''
        @order_payment.valid?
        expect(@order_payment.errors.full_messages).to include "City can't be blank"
      end
      it '番地が空欄だと登録できない' do
        @order_payment.addresses = ''
        @order_payment.valid?
        expect(@order_payment.errors.full_messages).to include "Addresses can't be blank"
      end
      it '電話番号は半角数字でないと登録できない' do
        @order_payment.phone_number = '０123456789'
        @order_payment.valid?
        expect(@order_payment.errors.full_messages).to include 'Phone number Please enter half-width numbers (up to 11 digits)'
      end
      it '電話番号に「-」が入っているとと登録できない' do
        @order_payment.phone_number = '012-34567890'
        @order_payment.valid?
        expect(@order_payment.errors.full_messages).to include 'Phone number Please enter half-width numbers (up to 11 digits)'
      end
      it 'トークンが空欄だと登録できない' do
        @order_payment.token = ''
        @order_payment.valid?
        expect(@order_payment.errors.full_messages).to include "Token can't be blank"
      end
      it 'user_idが空だと保存できない' do
        @order_payment.user_id = ''
        @order_payment.valid?
        expect(@order_payment.errors.full_messages).to include "User can't be blank"
      end
      it 'item_idが空だと保存できない' do
        @order_payment.item_id = ''
        @order_payment.valid?
        expect(@order_payment.errors.full_messages).to include "Item can't be blank"
      end
    end
  end
end
