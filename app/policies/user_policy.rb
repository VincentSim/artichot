class UserPolicy < ApplicationPolicy

  def show?
    @user  ==  @record
  end

  def edit?
    @user  ==  @record
  end

  def update?
    edit?
  end

  def edit_password?
    edit?
  end

  def update_password?
    edit?
  end

  def favorites?
    edit?
  end

  def my_presentations?
    edit?
  end

end
