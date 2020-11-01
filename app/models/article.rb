class Article < ActiveRecord::Base
	def article_type_name
		if self.article_type == 0
			return "オプション"
		elsif self.article_type == 1
			return "記事"
		end
	end
	def fixed_image_url
		if self.thumbnail == ""
			return "/assets/common/common2.jpg"
		else
			return self.thumbnail
		end
	end
end
