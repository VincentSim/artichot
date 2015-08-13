class EspacePolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    true
  end

  def new?
    !@user.nil?
  end

  def create?
    !@user.nil?
  end

  def update?
    @user  ==  @record.user
  end

  def destroy?
    update?
  end

end
