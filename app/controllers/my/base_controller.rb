class My::BaseController < ApplicationController
  before_action :authenticate_user!

  private
  def set_user
    @user = User.find(current_user.id)
  end
end
