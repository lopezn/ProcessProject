require 'prawn'

class ArticlesController < ApplicationController

	def new
		# The new article to be created
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
		@article = Article.find(params[:id])

		@pdf = Prawn::Document.new
		@pdf.text @article.title, :size => 30
		@pdf.move_down 15
		@pdf.text @article.text

		send_data @pdf.render, :filename => "#{@article.title}.pdf", :type => "application/pdf"
	end

	#def upload
	#	@article = Article.find(params[:id])
	#	uploaded_io = params[:article][:stuff]
	#	File.open(Rails.root.join('app', 'assets', uploaded_io.original_filename), 'wb') do |file|
	#		file.write(uploaded_io.read)
	#	end
	#	redirect_to articles_path
	#end
	
	def upvote
		@article = Article.find(params[:id])
		@article.votes = @article.votes + 1
		@article.save
		
		redirect_to @article
	end
	
	def downvote
		@article = Article.find(params[:id])
		@article.votes = @article.votes - 1
		@article.save
		
		redirect_to @article
	end

	private
		def article_params
		  	params.require(:article).permit(:title, :text)
		end
end
