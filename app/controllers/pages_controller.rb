class PagesController < ApplicationController
  skip_after_action :verify_authorized
  def home
    @home_page = true
  end
end