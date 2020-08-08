class FavoritesController < ApplicationController
before_action :authenticate_user!
  before_action :set_music

  def create
    @music.favorites.create(user_id: current_user.id)
    redirect_back(fallback_location: root_path)
   #通知の作成
      @music.create_notification_by(current_user)
  end

  def destroy
    favorite = current_user.favorites.find_by(music_id: @music.id)
    favorite.destroy
    redirect_back(fallback_location: root_path)
  end

  private

  def set_music
    @music = Music.find(params[:music_id])
  end

  def favorite_params
    params.require(:favorite).permit(:user_id, :music_id)
  end
end

