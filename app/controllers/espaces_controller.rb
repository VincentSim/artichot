class EspacesController < ApplicationController
  before_action :set_espace, only: [:show, :edit, :update, :destroy]
  before_action :find_and_authorize_espace, only: [:edit, :update, :destroy]
  before_action :build_and_authorize_espace, only: [:new, :create]
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

  respond_to :html

  def index
    @address = params[:user_input_autocomplete_address] || params[:nav_user_input_autocomplete_address]
    @nb_results = Espace.near(@address, 10).size
    if @nb_results == 0
      @espaces = Espace.all.page(params[:page]).per(10)
    else
      @espaces = Espace.near(@address, 10).page(params[:page]).per(10)
    end
    p "=== debug ===="
    p @nb_results
    p @espaces

    # Gmaps markers
    @markers = Gmaps4rails.build_markers(@espaces) do |espace, marker|
      p marker.lat espace.latitude
      p marker.lng espace.longitude
    end
    respond_to do |format|
      format.html
      format.js
    end
  end

  def show
    @address = params[:address]
    @art_piece = ArtPiece.new

    if current_user
      @follow = Follow.where(:espace_id => @espace.id, :user_id => current_user.id).first || Follow.new
    end
     # Gmaps marker
    @markers = Gmaps4rails.build_markers(@espace) do |espace, marker|
      p marker.lat espace.latitude
      p marker.lng espace.longitude
    end
    respond_with(@espace)
  end

  def new
    if current_user.espaces.size != 0
      @espace = current_user.espaces.last
      respond_to do |format|
        format.html { redirect_to espace_path(@espace), notice: 'You have already an espace' }
        format.js
      end
    else
      @espace = Espace.new
      respond_with(@espace)
    end
  end

  def edit
  end

  def create
    @espace = current_user.espaces.create(espace_params)

    redirect_to espace_path(@espace)
  end

  def update
    @espace.update(espace_params)
    respond_with(@espace)
  end

  def destroy
    @espace.destroy
    respond_with(@espace)
  end

  private
    def set_espace
      @espace = Espace.find(params[:id])
    end

    def espace_params
      params.require(:espace).permit(:name, :description, :address, :street_number, :route, :locality, :country, :category, :picture)
    end
    def find_and_authorize_espace
      set_espace
      authorize @espace
    end

    def build_and_authorize_espace
      @espace = Espace.new
      authorize @espace
    end
end
