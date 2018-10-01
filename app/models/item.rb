class Item < ApplicationRecord
  belongs_to :cupboard, optional: true
  accepts_nested_attributes_for :cupboard
  validates :cupboard_id, presence: true
end