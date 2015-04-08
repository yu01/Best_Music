module PostConcern
  extend ActiveSupport::Concern

  private

  def uniqie(post)
    @posts = Post.order(:updated_at).reverse_order
    old_post = @posts.find{ |p| p.url == post.url }
    old_post ? return Time.now > old_post.updated_at + 60 * 60 * 24 * 30 * 6 : true
  end

  def generateTitle(url)
    begin
      client = YouTubeIt::Client.new(:dev_key => "AIzaSyAJCoJz6Tt9xnHRKTFiZpwNjjcycG0N3zA")
      video = client.video_by(url)
      words =  video.title.split
      newtitle = ""
      words.each { |word| newtitle += Unicode::capitalize(word) + " " }
      return newtitle
    rescue
      return "Error with url #{@post.url}"
    end
  end

  def generateURL(url)
    index = url.index('=')
    if !index
      path = 'embed/'
      index = url.index(path)
      if index == nil
        return ""
      else
        index += + path.size
      end
    else
      index += 1
    end
    n = url.length
    returnUrl = ""
    returnUrl = "https://www.youtube.com/embed/" + url[index..n]
  end

  def getTags(title)
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
    begin
      artist.tags.each do |tag|
        tag.split.each do |word|
          @tags += Unicode::capitalize(word)+ " "
        end
        @tags = @tags.chop
        @tags += ", "
      end
      @tags = @tags.chop.chop
      return @tags
    rescue
      return ""
    end
  end

  def getpost(post)
    post.title = generateTitle(post.url)
    post.url = generateURL(post.url)
    post.tags = getTags(post.title)
    post
  end

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :url, :tags, :suit, :vote)
  end
end
