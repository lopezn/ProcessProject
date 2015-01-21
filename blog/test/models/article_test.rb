require 'test_helper'

class ArticleTest < ActiveSupport::TestCase
	
	test "should have a title" do
		expected = articles(:ValidArticle)
		actual = Article.find(expected)

		assert_equal expected.title, actual.title
	end

	test "should have text" do
		expected = articles(:ValidArticle)
		actual = Article.find(expected)

		assert_equal expected.text, actual.text
	end

	test "should not save an article without a title" do
		article = Article.new
		assert_not article.save
	end

	test "should not save an article with a title whose length is less than 5" do
		article = Article.new
		article.title = "1234"
		assert_not article.save
	end

	test "should save a valid article" do
		article = Article.new
		article.title = "12345"
		assert article.save
	end

	test "can have no comments" do
		actual = Article.find(articles(:WithNoComments))

		assert_equal 0, actual.comments.count
	end

	test "can have one comment" do
		actual = Article.find(articles(:WithOneComment))

		assert_equal 1, actual.comments.count
	end

	test "can have multiple comments" do
		actual = Article.find(articles(:WithTwoComments))

		assert_equal 2, actual.comments.count
	end

	test "destroying an article destroys associated comments" do
		actual = Article.find(articles(:WithOneComment))
		comment_id = comments(:ForArticleWithOneComment).id

		actual.destroy

		assert_not Comment.exists?(comment_id)
	end

end
