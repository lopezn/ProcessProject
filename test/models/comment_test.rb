require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  test "should have a commenter" do
		expected = comments(:ValidComment)
		actual = Comment.find(expected)

		assert_equal expected.commenter, actual.commenter
	end

	test "should have a body" do
		expected = comments(:ValidComment)
		actual = Comment.find(expected)

		assert_equal expected.body, actual.body
	end

	test "should belong to an article" do
		comment = comments(:ValidComment)
		expectedArticle = articles(:ValidArticle)

		actualComment = Comment.find(comment)
		actualArticle = Article.find(comment.article_id)

		assert_equal expectedArticle, actualArticle
	end
end
