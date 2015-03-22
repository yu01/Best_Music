class UserController < ApplicationController
  
  def add
    @post = Post.new
  end

  def show
    @posts = Post.order(:updated_at).reverse_order

    @posts = @posts.where("suit = true")

    @posts = @posts.where("created_at < ?", Time.now)

    @posts = @posts.paginate(page: params[:page], per_page: 2)

    respond_to do |format|
        format.html
        format.js
      end


  end

end
