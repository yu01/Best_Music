class TencetController < ApplicationController

  http_basic_authenticate_with name: "tencet", password: "qk35lm"
  
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
