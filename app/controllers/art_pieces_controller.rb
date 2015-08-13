class ArtPiecesController < ApplicationController
  before_action :set_espace, only: [:destroy]
  before_action :authenticate_user!, only: [:create, :destroy]

  def create
    @espace = Espace.find(art_piece_params[:espace_id])
    @art_piece = @espace.art_pieces.create(art_piece_params)

    if @art_piece.save
      respond_to do |format|
        format.html { redirect_to espace_path(@espace)}
        format.js
      end
    else
      respond_to do |format|
        format.js
      end
    end
  end

  private
    def set_art_piece
      @art_piece = art_piece.find(params[:id])
    end

    def art_piece_params
      params.require(:art_piece).permit(:title, :picture, :espace_id)
    end
end