class ArticlesController < ApplicationController

	def new
		@article = Article.new
	end

	def create
		@article = Article.new(article_params)

		if @article.save
			redirect_to @article
		else
			render 'new'
		end
	end

	def show
		@article = Article.find(params[:id])
		#@article.text = "changed"
	end

	def index
		@articles = Article.all
	end

	def edit
		@article = Article.find(params[:id])
	end	

	def update
		@article = Article.find(params[:id])

		if @article.update(article_params)
			redirect_to @article
		else
			render 'edit'
		end
	end

	def destroy
		@article = Article.find(params[:id])
		@article.destroy

		redirect_to articles_path
	end

	def download
		send_file Rails.root.join('app', 'assets', 'images', 'Penguins.jpg')
	end

	def upload
		@article = Article.find(params[:id])
		uploaded_io = params[:article][:stuff]
		File.open(Rails.root.join('app', 'assets', uploaded_io.original_filename), 'wb') do |file|
			file.write(uploaded_io.read)
		end
		redirect_to articles_path
	end

	private
		def article_params
		    params.require(:article).permit(:title, :text)
		end
end
