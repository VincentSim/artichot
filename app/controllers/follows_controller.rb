class FollowsController < ApplicationController
  before_action :find_and_authorize_follow, only: [:destroy]
  before_action :build_and_authorize_follow, only: [ :create]

  def create
    @user = User.find(follow_params[:user_id])
    @espace = Espace.find(params[:espace_id])
    @follow = @user.follows.new(user_id: @user.id, espace_id: @espace.id)
    if @follow.save
      respond_to do |format|
        format.html { redirect_to espace_path(@espace), notice: 'You follow this espace' }
        format.js
      end
    else
      respond_to do |format|
        format.js
      end
    end
  end

  def destroy
    @espace = Espace.find(@follow.espace)
    @follow.destroy
    @follow = Follow.new
    respond_to do |format|
      format.html { redirect_to espace_path(@espace), notice: 'You unfollow this espace' }
      format.js
    end
  end


private
  # Use callbacks to share common setup or constraints between actions.
  def set_follow
    @follow = Follow.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def follow_params
    params.require(:follow).permit(:user_id, :espace_id)
  end

  def find_and_authorize_follow
    set_follow
    authorize @follow
  end

  def build_and_authorize_follow
    @follow = Follow.new
    authorize @follow
  end
end