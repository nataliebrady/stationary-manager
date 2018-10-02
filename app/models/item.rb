class Item < ApplicationRecord
  belongs_to :cupboard, optional: true
  accepts_nested_attributes_for :cupboard
  has_many :user_items, dependent: :destroy
end