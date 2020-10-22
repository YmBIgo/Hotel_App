class Remainroom < ActiveRecord::Base
	def start_time
		self.room_date
	end
end
