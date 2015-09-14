class FavoriteshipsController < ApplicationController
  before_action :logged_in_user
  
  def create
    @micropost = Micropost.find(params[:micropost_id])
    current_user.favo(@micropost)
    @feed_item = @micropost
  end
  
  def destroy
    @micropost = Micropost.find(params[:micropost_id])
    current_user.unfavo(@micropost)
    @feed_item = @micropost
  end
end
