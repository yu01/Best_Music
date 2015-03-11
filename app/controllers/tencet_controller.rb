class TencetController < ApplicationController

  http_basic_authenticate_with name: "tencet", password: "qk35lm"

  def index
    @posts = Post.order(:created_at).reverse_order
  end

  def show 
   @post = Post.new
   @post.title = params[:title]
   @post.url = params[:url]
   @post.tags = params[:tags]
  end

end
