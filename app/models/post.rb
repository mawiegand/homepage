class Post < ApplicationRecord
  resourcify
  validates_presence_of :title, :body
end
