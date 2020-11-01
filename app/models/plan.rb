class Plan < ActiveRecord::Base
	def fixed_image_url
		if self.photo_url == ""
			return "/assets/IMG_5632.JPG"
		else
			return self.photo_url
		end
	end
end
