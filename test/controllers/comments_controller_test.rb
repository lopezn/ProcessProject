require 'test_helper'

class CommentsControllerTest < ActionController::TestCase
  test "create loads the correct comment" do
  	@expectedArticle = articles(:ValidArticle)
  	post :create, article_id: @expectedArticle.id, comment: {commenter: 'Foo', body: 'bar'}
  	assert_equal @expectedArticle, assigns(:article)
  end

  test "create saves a comment on the article" do
  	@expectedArticle = articles(:ValidArticle)
  	post :create, article_id: @expectedArticle.id, comment: {commenter: 'Foo', body: 'bar'}
  	assert_equal @expectedArticle, assigns(:article)
  end

  test "redirects to the article show" do
  	@expectedArticle = articles(:ValidArticle)
  	post :create, article_id: @expectedArticle.id, comment: {commenter: 'Foo', body: 'bar'}
  	assert_redirected_to @expectedArticle
  end

  test "destroy removes the comment" do
		@commentId = comments(:ValidComment)
		@expectedArticle = articles(:ValidArticle)
		get :destroy, id: @commentId, article_id: @expectedArticle
		assert_not Comment.exists?(@commentId)		
	end

	test "destroy assigns the article" do
		@commentId = comments(:ValidComment)
		@expectedArticle = articles(:ValidArticle)
		get :destroy, id: @commentId, article_id: @expectedArticle
		assert_equal @expectedArticle, assigns(:article)		
	end

	test "destroy redirects to article show" do
		@commentId = comments(:ValidComment)
		@expectedArticle = articles(:ValidArticle)
		get :destroy, id: @commentId, article_id: @expectedArticle
		assert_redirected_to article_path(@expectedArticle)		
	end
end
