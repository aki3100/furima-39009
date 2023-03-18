class OrderPayment
  include ActiveModel::Model
  attr_accessor :user_id, :item_id, :postal_code, :prefecture_id, :city, :addresses, :building, :phone_number

  with_options presence: true do
    validates :user_id
    validates :item_id
    validates :postal_code,  format: {with: /\A\d{3}[-]\d{4}\z/, message: "is invalid."}
    validates :prefecture_id, numericality: { other_than: 0, message: '「---」以外を選んでください' }
    validates :city
    validates :addresses
    validates :phone_number, format: {with: /\A[0-9]{11}+\z/, message: "is invalid."}
  end
end