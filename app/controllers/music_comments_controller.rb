class MusicCommentsController < ApplicationController
		  before_action :authenticate_user!
  before_action :ensure_correct_user, only: %i(destroy)

  def create
    music_comment = current_user.music_comments.new(music_comment_params)
    unless music_comment.save
      flash[:danger] = music_comment.errors
      redirect_back fallback_location: root_path
    end
    @music_comments = Music.find(params[:music_id]).music_comments
  end

  def destroy
    music_comment = MusicComment.find(params[:id])
    music_comment.destroy
    @music_comments = Music.find(music_comment.music_id).music_comments
  end

  private

  def music_comment_params
    params.require(:music_comment).permit(:content).merge(music_id: params[:music_id])
  end

  def ensure_correct_user
    music_comment = MusicComment.find(params[:id])
    return if music_comment.user_id == current_user.id
    flash[:danger] = '権限がありません'
    redirect_back fallback_location: root_path
  end
end
end

end
