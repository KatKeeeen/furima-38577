class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to  :user
  belongs_to  :category
  belongs_to  :state
  belongs_to  :shopping_charge
  belongs_to  :prefecture
  belongs_to  :delivery_time
  has_one_attached :image

  with_options presence: true do
    validates :image
    validates :name
    validates :description
    validates :price, numericality: { only_integer: true, message: " is invalid. Input half-width characters" }
    validates :price, numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999, message: "is out of setting range" }
    validates :category_id,        numericality: { other_than: 1, message: "can't be blank" }
    validates :state_id,           numericality: { other_than: 1, message: "can't be blank" }
    validates :shopping_charge_id, numericality: { other_than: 1, message: "can't be blank" }
    validates :prefecture_id,      numericality: { other_than: 1, message: "can't be blank" }
    validates :delivery_time_id,   numericality: { other_than: 1, message: "can't be blank" }
  end

end
