class TencetController < ApplicationController

  http_basic_authenticate_with name: "tencet", password: "qk35lm"

  def index
    @posts = Post.order(:created_at)

    @countPosts = 0

    @posts.each do |post|
      if !post.suit
         @countPosts += 1

      end

    end

    @countPostsDay = 0

    @posts.each do |post|
      if !post.suit && Time.now < post.created_at + 60 * 60 * 24
         @countPostsDay += 1

      end

    end

    

  end

  def all
    @posts = Post.order(:updated_at).reverse_order

  end
end
