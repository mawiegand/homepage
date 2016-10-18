class Post < ApplicationRecord
  resourcify
  validates_presence_of :title, :content
  default_scope { order('created_at DESC') }
  has_and_belongs_to_many :tags

  def content_preview
    content.truncate(SETTINGS['post_preview_sign_length']).bbcode_to_html unless content.nil?
  end

  def content_with_bbcode_and_formatting
    content.bbcode_to_html_with_formatting unless content.nil?
  end

  def self.latest(count = SETTINGS['count_of_posts_on_index_page'])
    limit(count)
  end
end
