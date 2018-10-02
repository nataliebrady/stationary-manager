class UserItem < ApplicationRecord
	belongs_to :user 
	belongs_to :item
	
	scope :not_returned, -> { where(returned: false) }
    scope :returned, -> { where(returned: true) }

    # Calculating the return date 
    def return_date
      (created_at + 2.day).strftime("%d/%m/%Y")
    end
    
    # Fine for books that have been rented more than 2 days
    def fine
      date_of_return = Date.parse(return_date)
      date_today = Date.today
      if date_today > date_of_return && returned == false
        fine = (date_today - date_of_return).to_i * 1.00
        return fine
      else
        return "0.00"
      end
    end

end