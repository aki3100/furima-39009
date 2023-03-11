require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end
  describe 'ユーザー新規登録' do
    context '新規登録できる場合' do
      it "nicknameとemail、passwordとpassword_confirmation、
      last_name・first_name（漢字・ひらがな・カタカナいずれかで入力）、
      last_name_kana・first_name_kana（カタカナで入力）、
      生年月日が存在すれば登録できる" do
        expect(@user).to be_valid
      end
      it 'パスワードが6文字以上半角英数字であれば登録できる' do
        @user.password = '123abc'
        @user.password_confirmation = '123abc'
        expect(@user).to be_valid
      end
      it '名字が全角（漢字・ひらがな・カタカナ）であれば登録できる' do
        @user.last_name = '山田'
        expect(@user).to be_valid
      end
      it '名前が全角（漢字・ひらがな・カタカナ）であれば登録できる' do
        @user.first_name = '太郎'
        expect(@user).to be_valid
      end
      it '名字のフリガナが全角（カタカナ）であれば登録できる' do
        @user.last_name_kana = 'ヤマダ'
        expect(@user).to be_valid
      end
      it '名前のフリガナが全角（カタカナ）であれば登録できる' do
        @user.first_name_kana = 'タロウ'
        expect(@user).to be_valid
      end
    end
    context '新規登録できない場合' do
      it 'nicknameが空だと登録できない' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "Nickname can't be blank"
      end
      it 'emailが空では登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "Email can't be blank"
      end
      it '重複しているemailアドレスは登録できない(一意性の確認)' do
        @user.save
        another_user = FactoryBot.build(:user, email: @user.email)
        another_user.valid?
        expect(another_user.errors.full_messages).to include 'Email has already been taken'
      end
      it 'メールアドレスは、@を含むものでないと登録できない' do
        @user.email = 'testmail'
        @user.valid?
        expect(@user.errors.full_messages).to include 'Email is invalid'
      end
      it 'パスワードが空だと登録できない' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "Password can't be blank"
      end
      it 'パスワードは6文字以上でないと登録できない' do
        @user.password = 'a1111'
        @user.valid?
        expect(@user.errors.full_messages).to include 'Password is too short (minimum is 6 characters)'
      end
      it '英字のみでのパスワードでは登録できない' do
        @user.password = 'aaaaaa'
        @user.valid?
        expect(@user.errors.full_messages).to include "Password confirmation doesn't match Password"
      end
      it '数字のみでのパスワードでは登録できない' do
        @user.password = '111111'
        @user.valid?
        expect(@user.errors.full_messages).to include "Password confirmation doesn't match Password"
      end
      it 'パスワードと確認用パスワードは一致していないと登録できない' do
        @user.password = 'a11111'
        @user.password_confirmation = 'b11111'
        @user.valid?
        expect(@user.errors.full_messages).to include "Password confirmation doesn't match Password"
      end
      it '名字(全角)が空だと登録できない' do
        @user.last_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "Last name can't be blank"
      end
      it '名前(全角)が空だと登録できない' do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "First name can't be blank"
      end
      it '名字が全角（漢字・ひらがな・カタカナ）以外は登録できない' do
        @user.last_name = 'yamada'
        @user.valid?
        expect(@user.errors.full_messages).to include 'Last name is invalid'
      end
      it '名前は全角（漢字・ひらがな・カタカナ）以外は登録できない' do
        @user.first_name = 'tarou'
        @user.valid?
        expect(@user.errors.full_messages).to include 'First name is invalid'
      end
      it '名字(全角)が空だと登録できない' do
        @user.last_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "Last name kana can't be blank"
      end
      it '名前(全角)が空だと登録できない' do
        @user.first_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "First name kana can't be blank"
      end
      it '名字カナは、全角（カタカナ）で入力しないと登録できない' do
        @user.last_name_kana = 'かな'
        @user.valid?
        expect(@user.errors.full_messages).to include 'Last name kana is invalid'
      end
      it '名前カナは、全角（カタカナ）で入力しないと登録できない' do
        @user.first_name_kana = 'かな'
        @user.valid?
        expect(@user.errors.full_messages).to include 'First name kana is invalid'
      end
      it '生年月日が空だと登録できない' do
        @user.birth_date = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "Birth date can't be blank"
      end
    end
  end
end
