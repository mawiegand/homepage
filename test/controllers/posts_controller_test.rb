require 'test_helper'

class PostsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @post = posts(:one)
    @admin = users(:administrator)
    @user = users(:user)
  end

  test "should get index" do
    get posts_url
    assert_response :success
  end

  test "should redirect instead of getting new" do
    get new_post_url
    assert_redirected_to new_user_session_path
  end

  test "should not get new" do
    sign_in @user

    exception = assert_raise(CanCan::AccessDenied) {
      get new_post_url
    }
    assert_equal 'You are not authorized to access this page.', exception.message
  end

  test "should get new" do
    sign_in @admin

    get new_post_url
    assert_response :success
  end

  test "should redirect instead of creating new post" do
    post posts_url, params: { post: { content: @post.content, title: @post.title } }
    assert_redirected_to new_user_session_path
  end

  test "should not create post" do
    sign_in @user

    exception = assert_raise(CanCan::AccessDenied) {
      post posts_url, params: { post: { content: @post.content, title: @post.title } }
    }
    assert_equal 'You are not authorized to access this page.', exception.message
  end

  test "should create post" do
    sign_in @admin

    assert_difference('Post.count') do
      post posts_url, params: { post: { content: @post.content, title: @post.title } }
    end

    assert_redirected_to post_url(Post.first)
  end

  test "should show post" do
    get post_url(@post)
    assert_response :success
  end

  test "should redirect instead of editing post" do
    get edit_post_url(@post)
    assert_redirected_to new_user_session_path
  end

  test "should not get edit" do
    sign_in @user

    exception = assert_raise(CanCan::AccessDenied) {
      get edit_post_url(@post)
    }
    assert_equal 'You are not authorized to access this page.', exception.message
  end

  test "should get edit" do
    sign_in @admin

    get edit_post_url(@post)
    assert_response :success
  end

  test "should redirect instead of updating post" do
    patch post_url(@post), params: { post: { content: @post.content, title: @post.title } }
    assert_redirected_to new_user_session_path
  end

  test "should not update post" do
    sign_in @user

    exception = assert_raise(CanCan::AccessDenied) {
      patch post_url(@post), params: { post: { content: @post.content, title: @post.title } }
    }
    assert_equal 'You are not authorized to access this page.', exception.message
  end

  test "should update post" do
    sign_in @admin

    patch post_url(@post), params: { post: { content: @post.content, title: @post.title } }
    assert_redirected_to post_url(@post)
  end

  test "should redirect instead of destroying post" do
    delete post_url(@post)
    assert_redirected_to new_user_session_path
  end

  test "should not destroy post" do
    sign_in @user

    exception = assert_raise(CanCan::AccessDenied) {
      delete post_url(@post)
    }
    assert_equal 'You are not authorized to access this page.', exception.message
  end

  test "should destroy post" do
    sign_in @admin

    assert_difference('Post.count', -1) do
      delete post_url(@post)
    end

    assert_redirected_to posts_url
  end
end
