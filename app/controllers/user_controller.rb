class UserController < ApplicationController
  
  helper_method :getTags

  def add
    @post = Post.new
  end

  def show
    @posts = Post.order(:created_at).reverse_order

  end

  def getTags(title)

    index = title.index('-')

    nameArtist = title[0..index - 1].strip

    #nameArtist = "Jungle Rot"

    Rockstar.lastfm = {
      :api_key => "d600f9fe67a8a859de883023e7ad29a6", 
      :api_secret => "adebc8c3ece7e08cfa1bb66ecafd0ba6"}

    artist = Rockstar::Artist.new(nameArtist, :include_info => true)

    @tags = ""

    artist.tags[0..2].each { |tag| @tags += tag + ", " }

    @tags.chop.chop

  end



end
