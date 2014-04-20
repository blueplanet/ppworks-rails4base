class My::AccountSetupsController < My::BaseController
  skip_before_action :user_ready?
  before_action :set_user
  respond_to :html

  def edit
    respond_with(@user)
  end
end
