class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :items
  has_many :orders

  with_options presence: true do
    validates :nickname
    # パスワードは、半角英数字混合での入力が必須であること（英字のみ・数字のみは不可）
    PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i.freeze
    validates_format_of :password, with: PASSWORD_REGEX

    # 全角文字を含むパスワードでは登録できない
    validates :password, format: { with:  /\A[a-z0-9]+\z/i }

    # 全角（漢字・ひらがな・カタカナ）
    validates :last_name, format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/ }
    validates :first_name, format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/ }
    # 全角（カタカナ）
    validates :last_name_kana, format: { with: /\A[ァ-ヶー]+\z/ }
    validates :first_name_kana, format: { with: /\A[ァ-ヶー]+\z/ }

    validates :birth_date

    # メモ・以下はdeviseにデフォルトでバリデーション機能が実装されている
    # ・メールアドレスが必須であること。
    # ・メールアドレスが一意性であること。
    # ・メールアドレスは、@を含む必要があること。
    # ・パスワードが必須であること。
    # ・パスワードは、6文字以上での入力が必須であること。
    # ・パスワードとパスワード（確認）は、値の一致が必須であること。
  end
end
