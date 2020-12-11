class Plan < ActiveRecord::Base

	validates :title, presence: true
	validates :price, presence: true, inclusion: { in: 3000..100000 }
	validates :people_num, presence: true, inclusion: { in: 1..4 }

	def fixed_image_url
		if self.photo_url == ""
			return "/assets/IMG_5632.JPG"
		else
			return self.photo_url
		end
	end
end
