class ArtPiecePolicy < ApplicationPolicy

  def create?
    !@user.nil?
  end


  def destroy?
    @user  ==  @record.espace.user
  end

end
