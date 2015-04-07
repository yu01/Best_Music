class UserController < ApplicationController
  respond_to :html, :js

  def add
    @post = Post.new
  end

  def show
    @footer_off = true
    @posts = Post.tencet_index.pagination(params[:page])
  end

  def about
  end
end
