class UserController < ApplicationController
  
  def add
    @post = Post.new
  end

  def show
    @posts = Post.order(:updated_at).reverse_order

    @posts = @posts.paginate(page: params[:page], per_page: 3)

  end

end
