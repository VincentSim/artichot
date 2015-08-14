class ProfilesController < ApplicationController
  before_action :set_user, only: [:edit, :update, :edit_password, :update_password, :favorites, :my_presentations]
  before_action :find_and_authorize_presentation, only: [:edit, :update, :edit_password, :update_password, :favorites, :my_presentations]

  def show
    @user = current_user
    if @user == current_user
      @presentations = @user.presentations.order("created_at DESC").page(params[:page]).per(10)
    else
      presentations = @user.presentations.order("created_at DESC").reject{|s|s.private == "private" }
      @presentations = Kaminari.paginate_array(presentations).page(params[:page]).per(10)
    end
    respond_to do |format|
      format.html
      format.js
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to profile_path(@user)
    else
      render "edit"
    end
  end

  def edit_password
  end

  def update_password
    if @user.update_with_password(user_password_params)
      sign_in @user, :bypass => true
      redirect_to edit_profile_path(@user)
    else
      render "edit_password"
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

  private
  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:user_name, :contact_email, :picture, :description)
  end

  def user_password_params
    params.required(:user).permit(:password, :password_confirmation, :current_password)
  end

  def find_and_authorize_presentation
    set_user
    authorize @user
  end
end