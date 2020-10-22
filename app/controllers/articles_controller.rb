class ArticlesController < ApplicationController

	before_action :authenticate_user!, :except => [:index, :show]

	def show
		@article = Article.find(params[:id])
	end
	def index
		if params[:is_option] == "0"
			@articles = Article.where(:article_type => 0)
		else
			@articles = Article.where(:article_type => 1)
		end
	end
	def new
		@article = Article.new
	end
	def create
		@article = Article.new(article_params)
		if @article.valid?
			@article.save!
			redirect_to "/articles/#{@article.id}"
		else
			redirect_to "/articles/new"
		end
	end
	def edit
		@article = Article.find(params[:id])
	end
	def update
		@article = Article.find(params[:id])
		if @article.valid?
			@article.update(article_params)
		end
		redirect_to "/articles/#{@article.id}"
	end
	def delete
	end

	private
	def article_params
		params.require(:article).permit(:title, :content, :author, :thumbnail, :article_type)
	end

end
