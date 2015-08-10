class EspacesController < ApplicationController
  before_action :set_espace, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

  respond_to :html

  def index
    @espaces = Espace.all
    respond_with(@espaces)
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
    @espace = Espace.new
    respond_with(@espace)
  end

  def edit
  end

  def create
    @espace = current_user.espaces.create(espace_params)
    binding.pry
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
