class ArticlesController < ApplicationController
	before_action :set_article, only: [:edit, :update, :show, :destroy]
	before_action :require_user, except: [:index, :show]
	before_action :require_same_user, only: [:edit, :update, :destroy]
	
	def index
		# @articles = Article.all
		@articles = Article.paginate(page: params[:page], per_page: 5) #can leave out per_page, and will set to default
	end

	def new
		@article = Article.new
	end

	def edit
	end

	def create
		# debugger
		# render plain: params[:article].inspect #This will display what was sent when created
		@article = Article.new(article_params)
		@article.user = current_user
		if @article.save
			flash[:success] = "Article was successfully created"
			redirect_to article_path(@article)
		else
			render 'new'  #Renders the new page agein /articles/new
		end
	end

	def update
		if @article.update(article_params)
			flash[:success] = "Article was successfully updated"
			redirect_to article_path(@article)
		else
			render 'edit'
		end
	end

	def show	
	end

	def destroy
		@article.destroy
		flash[:danger] = "Article was successfully deleted"
		redirect_to articles_path
	end

	private
	  def set_article
	  	@article = Article.find(params[:id])
	  end

	  def article_params
	  	params.require(:article).permit(:title, :description)  #Allows these values to go through to the table. Prevents editing of protected fields(like id)
	  end

	  def require_same_user
	  	if current_user != @article.user
	  		flash[:danger] = "HEY! Stop trying to edit/delete other user's articles!!"
	  		redirect_to root_path
	  	end
	  end
end