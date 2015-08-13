class LikesController < ApplicationController
  before_action :find_and_authorize_like, only: [:destroy]
  before_action :build_and_authorize_like, only: [ :create]

  def create
    @user = current_user
    @art_piece = ArtPiece.find(like_params[:art_piece_id])
    @like = @user.likes.new(user_id: @user.id, art_piece_id: @art_piece.id)
    if @like.save
      respond_to do |format|
        format.html { redirect_to art_piece_path(@art_piece), notice: 'You liked this art piece' }
        format.js
      end
    else
      respond_to do |format|
        format.js
      end
    end
  end

  def destroy
    @user = User.find(@like.user)
    @art_piece = ArtPiece.find(params[:art_piece_id])
    @like.destroy
    @like = Like.new
    respond_to do |format|
      format.html { redirect_to art_piece_path(@art_piece), notice: 'You unliked this art piece' }
      format.js
    end
  end


private
  # Use callbacks to share common setup or constraints between actions.
  def set_like
    @like = Like.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def like_params
    params.require(:like).permit(:user_id, :art_piece_id)
  end

  def find_and_authorize_like
    set_like
    authorize @like
  end

  def build_and_authorize_like
    @like = Like.new
    authorize @like
  end
end