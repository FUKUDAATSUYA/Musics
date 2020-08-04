class SearchesController < ApplicationController
	before_action :authenticate_user!

  def search
    case params[:path]
    when "musics"
      redirect_to musics_path(str: params[:str], type: params[:type])
    when "users"
      redirect_to users_path(str: params[:str], type: params[:type])
    else
    end
  end
end
