class EspacesController < ApplicationController
  before_action :set_espace, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

  respond_to :html

  def index
    # params
    @city = params[:user_input_autocomplete_address]
    @nb_results = Espace.near(@city, 10).size
    if @nb_results == 0
      @espaces = Espace.all
    else
      @espaces = Espace.near(@city, 10)
    end
    p "=== debug ===="
    p @nb_results
    p @espaces

    # Gmaps markers
    @markers = Gmaps4rails.build_markers(@espaces) do |espace, marker|
      p marker.lat espace.latitude
      p marker.lng espace.longitude
    end
  end

  def show
     # Gmaps marker
    @markers = Gmaps4rails.build_markers(@espace) do |espace, marker|
      p marker.lat espace.latitude
      p marker.lng espace.longitude
    end
    respond_with(@espace)
  end

  def new
    if current_user.espaces
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
      params.require(:espace).permit(:name, :description, :address, :street_number, :route, :locality, :country, :category)
    end
end
