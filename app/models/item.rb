class Item < ApplicationRecord
  validates :name, presence: true, length: { maximum: 50 }
  validates :item_quantity, presence: true
  validates :cupboard, presence: true
  belongs_to :cupboard, optional: true
  accepts_nested_attributes_for :cupboard
  has_many :user_items, dependent: :destroy
end