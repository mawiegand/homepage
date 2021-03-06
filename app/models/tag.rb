class Tag < ApplicationRecord
  resourcify
  validates :name, presence: true, uniqueness: true

  has_many :taggings
  has_many :posts, through: :taggings

  def self.counts
    self.select([:name, 'count(taggings.tag_id) as count']).joins(:taggings).group(:id)
  end
end
