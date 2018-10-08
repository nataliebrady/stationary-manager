class Cupboard < ApplicationRecord
  # making sure the name for the cupboard is present
  validates :name, presence: true, length: { maximum: 50 }
  # a cupboard has many items, if cupboard is destroyed - destroy the items associated with it
  has_many :items, dependent: :destroy
  # a cupboard accepts nested attributes for items and allows items to be destroyed
  accepts_nested_attributes_for :items, allow_destroy: true
end