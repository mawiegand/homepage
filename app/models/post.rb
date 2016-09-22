class Post < ApplicationRecord
  resourcify
  validates_presence_of :title, :body
  default_scope { order('created_at DESC') }

  def self.latest(count = SETTINGS['count_of_posts_on_index_page'])
    limit(count)
  end
end
