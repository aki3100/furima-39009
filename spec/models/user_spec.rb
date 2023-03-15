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
        expect(@user.errors.full_messages).to include 'Nicknameを入力してください'
      end
      it 'emailが空では登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include 'Emailを入力してください'
      end
      it '重複しているemailアドレスは登録できない(一意性の確認)' do
        @user.save
        another_user = FactoryBot.build(:user, email: @user.email)
        another_user.valid?
        expect(another_user.errors.full_messages).to include 'Emailはすでに存在します'
      end
      it 'メールアドレスは、@を含むものでないと登録できない' do
        @user.email = 'testmail'
        @user.valid?
        expect(@user.errors.full_messages).to include 'Emailは不正な値です'
      end
      it 'パスワードが空だと登録できない' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include 'Passwordを入力してください'
      end
      it 'パスワードは6文字以上でないと登録できない' do
        @user.password = 'a1111'
        @user.valid?
        expect(@user.errors.full_messages).to include 'Passwordは6文字以上で入力してください'
      end
      it '・全角文字を含むパスワードでは登録できない' do
        @user.password = 'a1111１'
        @user.valid?
        expect(@user.errors.full_messages).to include 'Passwordは不正な値です'
      end
      it '英字のみでのパスワードでは登録できない' do
        @user.password = 'aaaaaa'
        @user.valid?
        expect(@user.errors.full_messages).to include 'Passwordは不正な値です'
      end
      it '数字のみでのパスワードでは登録できない' do
        @user.password = '111111'
        @user.valid?
        expect(@user.errors.full_messages).to include 'Passwordは不正な値です'
      end
      it 'パスワードと確認用パスワードは一致していないと登録できない' do
        @user.password = 'a11111'
        @user.password_confirmation = 'b11111'
        @user.valid?
        expect(@user.errors.full_messages).to include 'Password confirmationとPasswordの入力が一致しません'
      end
      it '名字(全角)が空だと登録できない' do
        @user.last_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include 'Last nameを入力してください'
      end
      it '名前(全角)が空だと登録できない' do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include 'First nameを入力してください'
      end
      it '名字が全角（漢字・ひらがな・カタカナ）以外は登録できない' do
        @user.last_name = 'yamada'
        @user.valid?
        expect(@user.errors.full_messages).to include 'Last nameは不正な値です'
      end
      it '名前は全角（漢字・ひらがな・カタカナ）以外は登録できない' do
        @user.first_name = 'tarou'
        @user.valid?
        expect(@user.errors.full_messages).to include 'First nameは不正な値です'
      end
      it '名字(全角)が空だと登録できない' do
        @user.last_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include 'Last name kanaを入力してください'
      end
      it '名前(全角)が空だと登録できない' do
        @user.first_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include 'First name kanaを入力してください'
      end
      it '名字カナは、全角（カタカナ）で入力しないと登録できない' do
        @user.last_name_kana = 'かな'
        @user.valid?
        expect(@user.errors.full_messages).to include 'Last name kanaは不正な値です'
      end
      it '名前カナは、全角（カタカナ）で入力しないと登録できない' do
        @user.first_name_kana = 'かな'
        @user.valid?
        expect(@user.errors.full_messages).to include 'First name kanaは不正な値です'
      end
      it '生年月日が空だと登録できない' do
        @user.birth_date = ''
        @user.valid?
        expect(@user.errors.full_messages).to include 'Birth dateを入力してください'
      end
    end
  end
end
