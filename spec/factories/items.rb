FactoryBot.define do
  factory :item do
    item_name                    {"商品名のテスト"}
    item_info                    {}
    item_category_id             {"1"}
    item_sales_status_id         {"1"}
    item_shipping_fee_status_id  {"1"}
    item_prefecture_id           {"1"}
    item_scheduled_delivery_id   {"1"}
    item_price                   {}
    user                         {"1"}
  end
end
