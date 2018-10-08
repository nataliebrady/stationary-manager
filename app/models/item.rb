class Item < ApplicationRecord
  # item name must be present
  validates :name, presence: true, length: { maximum: 50 }
  # item quantity must be present
  validates :item_quantity, presence: true
  # cupboard must be present for item
  validates :cupboard, presence: true
  # an item can belong to a cupboard
  belongs_to :cupboard
  # an item accepts nested attributes for a cupboard
  accepts_nested_attributes_for :cupboard
  # an item has many orders, if item is destroyed - destroy the orders for that item as it no longer exists
  has_many :user_items, dependent: :destroy
end