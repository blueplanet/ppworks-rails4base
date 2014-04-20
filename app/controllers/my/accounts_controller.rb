class My::AccountsController < My::BaseController
  skip_before_action :user_ready?
  before_action :set_user
  respond_to :html

  def update
    @user.attributes = user_params
    if @user.save
      flash[:notice] = t('my.accounts.update.updated') unless request.xhr?
    end
    respond_with @user, location: root_path
  end

  private
  def user_params
    params.require(:user).permit(:name)
  end
end
