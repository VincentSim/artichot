class LikePolicy < ApplicationPolicy
  def create?
    !@user.nil?
  end


  def destroy?
    @user  ==  @record.user
  end
end
