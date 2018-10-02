class UserItem < ApplicationRecord
	belongs_to :user 
	belongs_to :item
	
	scope :not_returned, -> { where(returned: false) }
    scope :returned, -> { where(returned: true) }
end