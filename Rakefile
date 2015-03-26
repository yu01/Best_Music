# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

Rails.application.load_tasks



task :load_tags  => [:environment] do
  puts "0"
  @posts = Post.order(:updated_at).reverse_order

  puts "1"
  @posts = @posts.where("suit = true")

  puts "2"

  time = Time.now

  @posts = @posts.where("created_at < ?", time)


  @posts.each do |post|

    begin

      title = post.title

      index = title.index('-')

      if !index
        return ""
      end

      nameArtist = title[0..index - 1].strip

      Rockstar.lastfm = {
        :api_key => "d600f9fe67a8a859de883023e7ad29a6",
        :api_secret => "adebc8c3ece7e08cfa1bb66ecafd0ba6"}

      artist = Rockstar::Artist.new(nameArtist, :include_info => true)

      @tags = ""

      if !artist.tags
        return ""
      end

      artist.tags.each do |tag|
         tag.split.each do |word|
            @tags += Unicode::capitalize(word)+ " "
          end
          @tags = @tags.chop
          @tags += ", "
      end

      @tags = @tags.chop.chop

      post.tags = @tags

      post.save

    rescue

      post.tags = ""

      post.save

    end

  end

end
