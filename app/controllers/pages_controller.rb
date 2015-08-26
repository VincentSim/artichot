class PagesController < ApplicationController
  skip_after_action :verify_authorized
  def home
    @home_page = true
    @espaces = Espace.all.sample(3)
  end
end