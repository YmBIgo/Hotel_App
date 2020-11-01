class StaticController < ApplicationController
	def index
		@plans = Plan.all.limit(4)
		# options
		@options = Article.where(:article_type => 0).limit(3)
		# articles
		@articles = Article.where(:article_type => 1)
	end
end
