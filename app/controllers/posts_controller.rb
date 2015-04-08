class PostsController < ApplicationController
  include PostConcern

  http_basic_authenticate_with name: ENV["ADMIN_LOGIN"], password: ENV["ADMIN_PASS"], except: [:create, :upvote, :downvote]

  before_action :set_post, only: [:show, :edit, :update, :destroy, :suit, :day, :toNew, :upvote, :downvote]

  def index
  end

  def show
  end

  def new
    @post = Post.new
  end

  def edit
  end

  def create
    @post = Post.new(post_params)
    @post = getpost(@post)

    # WTF ?
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

  def suit
    @post.update_attributes suit: true
    redirect_to admin_path
  end

  def day
    @post.update_attributes created_at: @post.created_at + 1.day
    redirect_to admin_path
  end

  def toNew
    @post.update_attributes isNew: true
    redirect_to admin_path
  end

  def upvote
    @post.update_attributes upvote_by: current_user
    redirect_to :back
  end

  def downvote
    @post.update_attributes downvote_by: current_user
    redirect_to :back
  end
end
