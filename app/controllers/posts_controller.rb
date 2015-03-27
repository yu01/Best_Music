class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  http_basic_authenticate_with name: ENV["ADMIN_LOGIN"]  , password: ENV["ADMIN_PASS"], except: [:create, :upvote, :downvote]

  def index

  end

  def show
  end

  def new
    @post = Post.new
  end

  def edit

  end

  def uniqie (post)
    @posts = Post.order(:updated_at).reverse_order

    old_post = @posts.find{|p| p.url == post.url}

    if old_post
      return Time.now > old_post.updated_at + 60 * 60 * 24 * 30 * 6

    else
      true

    end


  end


  def create

    @post = Post.new(post_params)

    @post = getpost(@post)

    #getting title from Youtube API

    if !uniqie(@post)

      respond_to do |format|
        format.html { redirect_to show_path, notice: 'Ваше видео появится в списке после модерации' }
        format.json { render :show, status: :created, location: @post }
      end

      return
    end



    respond_to do |format|
      if @post.save
        format.html { redirect_to show_path, notice: 'Ваше видео появится в списке после модерации' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def getpost(post)

    post.title = generateTitle(post.url)

    post.url = generateURL(post.url)

    post.tags = getTags(post.title)

    return post

  end

  def generateTitle(url)

    begin
      client = YouTubeIt::Client.new(:dev_key => "AIzaSyAJCoJz6Tt9xnHRKTFiZpwNjjcycG0N3zA")

      video = client.video_by(url)


      words =  video.title.split

      newtitle = ""

      words.each {|word| newtitle += Unicode::capitalize(word) + " "}

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

  def suit

    @post = Post.find(params[:id])

    @post.suit = true

    if @post.save
      redirect_to admin_path
    end

  end

  def day

    @post = Post.find(params[:id])

    @post.created_at += 60 * 60 * 24

    if @post.save
      redirect_to admin_path
    end

  end

  def toNew

    @post = Post.find(params[:id])

    @post.isNew = true

    if @post.save
      redirect_to admin_path
    end

  end
  
  def upvote
    @post = Post.find(params[:id])
    @post.upvote_by current_user
    redirect_to :back
    
  end

  def downvote
    @post = Post.find(params[:id])
    @post.downvote_by current_user
    redirect_to :back
    
  end

  def update

    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to admin_path, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end

  end

  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to :back, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    def set_post
      @post = Post.find(params[:id])
    end

    def post_params
      params.require(:post).permit(:title, :url, :tags, :suit, :vote)
    end
end
