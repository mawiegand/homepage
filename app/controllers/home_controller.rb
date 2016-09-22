class HomeController < ApplicationController
  def show
    @posts = Post.latest
  end
end
