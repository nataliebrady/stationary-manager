class Cupboard < ApplicationRecord
  validates :name, presence: true, length: { maximum: 50 }
  has_many :items, dependent: :destroy
  accepts_nested_attributes_for :items, allow_destroy: true
end