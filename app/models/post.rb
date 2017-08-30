class Post < ApplicationRecord
  resourcify
  validates_presence_of :title, :content
  default_scope { order('created_at DESC') }
  has_many :taggings
  has_many :tags, through: :taggings
  belongs_to :category, inverse_of: :posts

  POST_BBCODE = {
    'Justify' => [
      /\[justify(:.+)?\](.*?)\[\/justify\1?\]/mi,
      "<div style=\"text-align: justify;\">\\2</div>",
      'Justifies contents',
      '[justify]Justified content[/justify]',
      :justify]
  }

  private_constant :POST_BBCODE

  def content_preview
    content.truncate(SETTINGS['post_preview_sign_length']).bbcode_to_html POST_BBCODE unless content.nil?
  end

  def content_with_bbcode
    content.bbcode_to_html POST_BBCODE unless content.nil?
  end

  def content_with_bbcode_and_formatting
    content.bbcode_to_html_with_formatting POST_BBCODE unless content.nil?
  end

  def self.latest(count = SETTINGS['count_of_posts_on_index_page'])
    limit(count)
  end

  # category section
  def self.in_category(name)
    Category.find_by_name!(name).posts
  end

  # tags section
  def all_tags=(names)
    self.tags = names.split(",").map do |name|
      Tag.where(name: name.strip).first_or_create!
    end
  end

  def all_tags
    self.tags.map(&:name).join(", ")
  end

  def self.tagged_with(name)
    Tag.find_by_name!(name).posts
  end
end
