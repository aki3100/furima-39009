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
