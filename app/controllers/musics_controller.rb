class MusicsController < ApplicationController
 before_action :authenticate_user!
  before_action :set_music, only: %i[show edit update destroy]
  before_action :ensure_correct_user, only: %i[edit update destroy]

 
  def index
    @musics = Music.all
  end

  def show; end


  def new
    @music = Music.new
  end

  def edit; end


  def create
    @music = Music.new(music_params)
    @music.user_id = current_user.id

    respond_to do |format|
      if @music.save
        format.html { redirect_to @music, notice: 'music was successfully created.' }
      else
        flash[:errors] = @music.errors.full_messages
        format.html { redirect_to music_path }
 
      end
    end
  end

  # PATCH/PUT /books/1
  # PATCH/PUT /books/1.json
  def update
    respond_to do |format|
      if @music.update(music_params)
        format.html { redirect_to @music, notice: 'music was successfully updated.' }
       
      else
        format.html { render :edit }
       
      end
    end
  end


  def destroy
    @music.destroy
    respond_to do |format|
      format.html { redirect_to musics_url, notice: 'Music was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private


  def set_music
    @music = Music.find(params[:id])
  end


  def music_params
    params.require(:music).permit(:title, :body)
  end

  def ensure_correct_user
    return if @music.user_id == current_user.id

    flash[:notice] = '権限がありません'
    redirect_to musics_path
  end
end
