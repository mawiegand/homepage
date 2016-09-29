require 'test_helper'

class PostTest < ActiveSupport::TestCase
  test "latest posts count from settings" do
    assert_no_difference(SETTINGS['count_of_posts_on_index_page'].to_s) do
      Post::latest
    end
  end

  test "latest post count" do
    count = 5
    assert_no_difference(count.to_s) do
      Post::latest(count)
    end
  end
end
