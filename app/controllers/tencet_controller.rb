class TencetController < ApplicationController
  def index
    @posts = Post.all
  end
end
