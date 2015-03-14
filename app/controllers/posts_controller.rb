class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  http_basic_authenticate_with name: "tencet", password: "qk35lm"

  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.order(:updated_at).reverse_order
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
    @post = getpost(@post)

  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(post_params)

    @post = getpost(@post)

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

  version = ">= 0"
  #load Gem.bin_path('railties', 'rails', version)

  def generateTitle(title)
     
    words =  @post.title.split

    newtitle = ""

    words.each {|word| newtitle += Unicode::capitalize(word) + " "}

    @post.title = newtitle

    @post.title

  end

  def generateURL(url)

    index = url.index('=')

    if index == nil

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

  def getpost(post)

    post.title = generateTitle(post.title)

    post.url = generateURL(post.url)

    post.tags = getTags(post.title)

    return post

  end

  
  def getTags(title)

    index = title.index('-')

    if index == nil
      return ""
    end

    nameArtist = title[0..index - 1].strip

    #nameArtist = "Jungle Rot"

    Rockstar.lastfm = {
      :api_key => "d600f9fe67a8a859de883023e7ad29a6", 
      :api_secret => "adebc8c3ece7e08cfa1bb66ecafd0ba6"}

    artist = Rockstar::Artist.new(nameArtist, :include_info => true)

    @tags = ""

    if artist.tags == nil
      return ""
    end

    artist.tags[0..2].each { |tag| @tags += tag + ", " }

    @tags.chop.chop

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



  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
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

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to admin_path, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:title, :url, :tags, :suit, :vote)
    end
end
