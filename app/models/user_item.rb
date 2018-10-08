class UserItem < ApplicationRecord
  # an order belongs to a user and an item
	belongs_to :user 
	belongs_to :item
	
  # defining scopes for whether the order is returned or not
	scope :not_returned, -> { where(returned: false) }
  scope :returned, -> { where(returned: true) }

    # calculating the return date 
    def return_date
      (created_at + 2.day).strftime("%d/%m/%Y")
    end

    # date user returned item
    def user_returned_date
      (updated_at).strftime("%d/%m/%Y")
    end
    
    # fine for items that have been borrowed more than 2 days and stopping fine from adding when item is returned
    def fine
      date_of_return = Date.parse(return_date)
      returned_date = Date.parse(user_returned_date)
      date_today = Date.today
      if date_today > date_of_return && returned == false
        fine = (date_today - date_of_return).to_i * 1.00
        return fine
      elsif date_today > date_of_return && returned == true
        fine = (returned_date - date_of_return).to_i * 1.00
        return fine
      else 
        return 0.00
      end
    end

end