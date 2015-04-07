class TencetController < ApplicationController
  http_basic_authenticate_with name: ENV["ADMIN_LOGIN"], password: ENV["ADMIN_PASS"]

  include TencetHelper

  respond_to :html, :js

  def index
    @posts = Post.tencet_index.pagination(params[:page])
  end

  def all
    @posts = Post.tencet_all.pagination(params[:page])
  end

  def statistic
  end
end
