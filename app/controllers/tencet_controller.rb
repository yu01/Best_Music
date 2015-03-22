class TencetController < ApplicationController

  http_basic_authenticate_with name: ENV["ADMIN_LOGIN"], password: ENV["ADMIN_PASS"]
  
  include TencetHelper  

  def index
    @posts = Post.order(:created_at)

    @countPosts = 0

    @posts.each do |post|
      if !post.suit || getDate(post) != ""
         @countPosts += 1

      end

    end

    @countPostsDay = 0

    @posts.each do |post|
      if Time.now < post.created_at + 60 * 60 * 24 && Time.now > post.created_at
         @countPostsDay += 1

      end

    end

  end

  def all
    @posts = Post.order(:updated_at).reverse_order

  end
end
