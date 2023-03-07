## Usersテーブル

|Column            |Type  |Options    |
|------------------|------|-----------|
|nickname          |string|null: false|
|email             |string|null: false|
|encrypted_password|string|null: false|
|last-name         |string|null: false|
|first-name        |string|null: false|
|last-name-kana    |string|null: false|
|first-name-kana   |string|null: false|

### Association
has_many :item
has_many :order


## ItemsTabel

|Column    |Type      |Options                      |
|----------|----------|-----------------------------|
|item-name |string    |null: false                  |
|item-info |text      |null: false                  |
|item-price|string    |null: false                  |
|user      |references|null: false,foreign_key: true|
|order     |references|null: false,foreign_key: true|

### Association
belongs_to :user
has_one :order


## OrdersTabel

|Column|Type      |Options                      |
|------|----------|-----------------------------|
|user  |references|null: false,foreign_key: true|
|item  |references|null: false,foreign_key: true|

### Association
belongs_to :user
has_one :item
has_one :shopping_address


## Shopping_addressesTabel

|Column      |Type  |Options    |
|------------|------|-----------|
|postal-code |string|null: false|
|city        |string|null: false|
|addresses   |string|null: false|
|building    |string|           |
|phone-number|string|null: false|

### Association
belongs_to:order