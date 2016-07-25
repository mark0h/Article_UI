class ArticlesController < ApplicationController
	
	def new
		@article = Article.new
	end

	def create
		# render plain: params[:article].inspect #This will display what was sent when created
		@article = Article.new(article_params)
		@article.save
		redirect_to articles_show(@article)
	end

	private
	  def article_params
	  	params.require(:article).permit(:title, :description)  #Allows these values to go through to the table. Prevents editing of protected fields(like id)
	  end
end