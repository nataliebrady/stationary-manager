class UserItem < ApplicationRecord
	belongs_to :user 
	belongs_to :item
	
	scope :not_returned, -> { where(returned: false) }
  scope :returned, -> { where(returned: true) }
  scope :fined, -> { where('created_at < ?', Date.today-2.days) }

    # Calculating the return date 
    def return_date
      (created_at + 2.day).strftime("%d/%m/%Y")
    end

    def user_returned_date
      (updated_at).strftime("%d/%m/%Y")
    end
    
    # Fine for books that have been rented more than 2 days
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