class Reservation < ActiveRecord::Base
	def start_time
		self.start_date
	end
	def end_time
		self.end_date
	end
end
