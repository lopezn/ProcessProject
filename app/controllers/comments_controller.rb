class CommentsController < ApplicationController
	def create
		# The article to add a comment to
		@article = Article.find(params[:article_id])
		
		# The comment to create
		@comment = @article.comments.create(comment_params)
		
		# Redirect back to article:show
		redirect_to article_path(@article)
	end

	def destroy
		@article = Article.find(params[:article_id])
		@comment = @article.comments.find(params[:id])
		@comment.destroy
		redirect_to article_path(@article)
	end

	private
		def comment_params
			params.require(:comment).permit(:commenter, :body)
		end
end
