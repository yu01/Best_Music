class UserController < ApplicationController
  
  def add
    @post = Post.new
  end

  def show
    @posts = Post.order(:updated_at).reverse_order

  end

end
