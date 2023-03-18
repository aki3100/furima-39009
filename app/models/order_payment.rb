class OrderPayment
  include ActiveModel::Model
  attr_accessor :user_id, :item_id, :postal_code, :prefecture_id, :city, :addresses, :building, :phone_number

  with_options presence: true do
    validates :user_id
    validates :item_id
    validates :postal_code
    validates :prefecture_id
    validates :city
    validates :addresses
    validates :building
    validates :phone_number
  
end