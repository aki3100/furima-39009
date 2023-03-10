require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end


  describe "ユーザー新規登録" do
    context '新規登録できる場合' do
      it"nicknameとemail、passwordとpassword_confirmation、名前（全角）と名前カナ（全角）と生年月日が存在すれば登録できる"do
        expect(@user).to.be_valid
      end
    end


    context '新規登録できない場合' do
      it "nicknameが空だと登録できない" do
        @user.nickname = ""
        @user.varid?
        expect(@user.errors.full_messages).to include "Nickname can't be blank"
      end
      
      it "emailが空では登録できない" do
        @user.email = ""
        @user.valid?
        expect(@user.errors.full_messages).to include "Email can't be blank"
      end

      it "重複しているemailアドレスは登録できない(一意性の確認)" do
        @user.save
        aunther_user = build(:user, email:@user.email)
        anather_user.valid?
        expect(another_user.errors.full_messages).to include "Email has already been taken"
      end

      it "メールアドレスは、@を含むものでないと登録できない" do
        @user.email = "testmail"
        @user.valid?
        expect(@user.errors.full_messages).to include "Email is invalid"
      end

      it "パスワードが空だと登録できない" do
      end

      it "パスワードは6文字以上でないと登録できない" do
      end

      it "パスワードは半角英数字の混合での入力でないと登録できない" do
      end

      it "パスワードと確認用パスワードは一致していないと登録できない" do
      end


    end
  end
end
