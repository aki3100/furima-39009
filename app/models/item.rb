class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions

  belongs_to :user
  has_one_attached :image

  # ActiveHashのアソシエーション
  belongs_to :category
  belongs_to :item_status
  belongs_to :shopping_charges
  belongs_to :prefecture
  belongs_to :shopping_date

  # 空白の場合はエラーが出るようにする設定
  with_options presence: true do
    validates :item_name
    validates :item_info
    validates :item_category_id
    validates :item_sales_status_id
    validates :item_shipping_fee_status_id
    validates :item_prefecture_id
    validates :item_scheduled_delivery_id
    validates :user_id
  end

  # 300円以上かつ9,999,999円以下で、半角数字でないと入力不可
  validates :item_price, numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999 }

  # ActiveHash「---」は保存できないようにする設定
  with_options numericality: { other_then: 0 , message: "can't be blank"} do
    validates :item_category_id
    validates :item_sales_status_id
    validates :item_shipping_fee_status_id
    validates :item_prefecture_id
    validates :item_scheduled_delivery_id
  end

end
