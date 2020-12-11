class Article < ActiveRecord::Base

	validates :title, presence: true, uniqueness: true
	validates :article_type, presence: true
	validates :content, presence: true
	validates :tag_ids, format: { with: /(([1-9]){0,1}[0-9](,){0,1}){1,10}|/ }
	validates :author, presence: true
	validates :article_type, inclusion: { in: [0, 1, 2] }

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
