class MusicsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: %i(edit update destroy)

  def show
    @music = Music.find(params[:id])
    @favorite = Favorite.new
    @music_comments = @music.music_comments
    @music_comment = MusicComment.new
  end

  def index
    @musics = Music.search("title", params[:str], params[:type])
    @favorite = Favorite.new
  end

  def create
    @music = Music.new(music_params)
    @music.user_id = current_user.id


    if @music.save
      flash[:success] = "successfully created music!"
     redirect_back fallback_location: root_path
    else
      @musics = Music.all
      flash.now[:danger] = @music.errors
      render 'index'
    end
  end

  def edit
    @music = Music.find(params[:id])
  end

  def update
    @music = Music.find(params[:id])
    if @music.update(music_params)
      flash[:success] = "successfully updated music!"
      redirect_to @music
    else
      flash.now[:danger] = @music.errors
      render "edit"
    end
  end

  def destroy
    @music = Music.find(params[:id])
    @music.destroy
    flash[:success] = "successfully delete music!"
    redirect_to musics_path
  end

  private

  def music_params
    params.require(:music).permit(:title, :body)
  end

  def ensure_correct_user
    @music = Music.find(params[:id])
    return if @music.user_id == current_user.id
    flash[:danger] = '権限がありません'
    redirect_to musics_path
  end
end
