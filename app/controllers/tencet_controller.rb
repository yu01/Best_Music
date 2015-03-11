class TencetController < ApplicationController

  http_basic_authenticate_with name: "tencet", password: "qk35lm"

  def index
    @posts = Post.order(:created_at).reverse_order
  end

end
