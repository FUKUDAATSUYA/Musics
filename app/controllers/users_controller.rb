class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: %i[show edit update]
  before_action :ensure_correct_user, only: %i[edit update]

  def index
    @users = User.all
  end

  def show
    @musics = @user.musics
  end

  def edit; end

  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        
      else
        format.html { render :edit }
        
      end
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end

  def ensure_correct_user
    return if @user.id == current_user.id

    flash[:notice] = '権限がありません'
    redirect_to user_path(current_user.id)
  end
end
