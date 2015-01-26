require 'test_helper'

class ArticlesControllerTest < ActionController::TestCase
	test "index loads all articles" do
	  get :index
	  assert_not_nil assigns(:articles)
	  assert_equal assigns(:articles).count, Article.count
	end

	test "index succeeds" do
		get :index
		assert_response :success
		assert_template :index
	end

	test "new constructs new article for the view" do
		get :new
		assert_equal nil, assigns(:article).title
	end

	test "new succeeds" do
		get :new
		assert_response :success
		assert_template :new		
	end

	test "create saves a valid article" do
		assert_difference('Article.count') do
	    post :create, article: {title: 'Hello', body: 'Stuff'}
	  end
	end

	test "create does not save an invalid article" do
		assert_difference('Article.count', 0) do
	    post :create, article: {title: 'Hi', body: 'Things'}
	  end
	end

	test "create redirects valid articles to show" do
		post :create, article: {title: 'Hello', body: 'Reasons'}
		assert_redirected_to article_path(assigns(:article))
	end

	test "create redirects invalid articles back to new" do 
		post :create, article: {title: 'Hi', body: 'Things'}
		assert_template :new
	end

	test "show loads the correct article" do
		@expectedArticle = articles(:ValidArticle)
		get :show, id: @expectedArticle.id
		assert_equal @expectedArticle, assigns(:article)
	end

	test "show succeeds" do
		get :show, id: articles(:ValidArticle).id
		assert_response :success
		assert_template :show
	end

	test "edit loads the correct article" do
		@expectedArticle = articles(:ValidArticle)
		get :edit, id: @expectedArticle.id
		assert_equal @expectedArticle, assigns(:article)
	end

	test "edit succeeds" do
		get :edit, id: articles(:ValidArticle).id
		assert_response :success
		assert_template :edit
	end

	test "update loads the correct article" do
		@expectedArticle = articles(:ValidArticle)
		get :edit, id: @expectedArticle.id
		assert_equal @expectedArticle, assigns(:article)
	end

	test "update redirects to the article if the updates are valid" do
		@expectedArticle = articles(:ValidArticle)
		post :update, id: @expectedArticle.id, article: {title: 'New Title', body: 'New Body'}
		assert_redirected_to @expectedArticle
	end

	test "update redirects to the update if the updates are invalid" do
		@expectedArticle = articles(:ValidArticle)
		post :update, id: @expectedArticle.id, article: {title: '', body: ''}
		assert_template :edit
	end

	test "destroy removes the article" do
		@articleId = articles(:ValidArticle)
		get :destroy, id: @articleId
		assert_not Article.exists?(@articleId)		
	end

	test "destroy redirects to articles page" do
		@articleId = articles(:ValidArticle)
		get :destroy, id: @articleId
		assert_redirected_to articles_path	
	end

end
