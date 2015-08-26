class ProfilesController < ApplicationController

  def show
    if current_user.id == params[:id].to_i
      @likes = current_user.likes.order("created_at DESC")
      @follows = current_user.follows
      @news = []
      @follows.each do |follow|
        follow.espace.art_pieces.each do |art_piece|
          @news << art_piece
        end
      end
      @sort_news = @news.sort_by{|news| news.updated_at}.reverse
    else
      redirect_to profile_path(id:current_user.id)
    end
  end

  def favorites
     @likes = current_user.likes.order("created_at DESC").page(params[:page] || 1).per(10)
     @presentations = @likes.map &:presentation
     respond_to do |format|
       format.html
       format.js
     end
   end

  def my_presentations
    @presentations = current_user.presentations.order("created_at DESC").page(params[:page]).per(10)
    respond_to do |format|
      format.html
      format.js
    end
  end
end