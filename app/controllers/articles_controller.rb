class ArticlesController < ApplicationController
	
	def new
		@article = Article.new
	end

	def create
		# render plain: params[:article].inspect #This will display what was sent when created
		@article = Article.new(article_params)
		if @article.save
			flash[:notice] = "Article was successfully created"
			redirect_to article_path(@article)
		else
			render 'new'  #Renders the new page agein /articles/new
		end
	end

	def show
	  @article = Article.find(params[:id])		
	end

	private
	  def article_params
	  	params.require(:article).permit(:title, :description)  #Allows these values to go through to the table. Prevents editing of protected fields(like id)
	  end
end