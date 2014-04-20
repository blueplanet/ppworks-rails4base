class ApplicationController < ActionController::Base
  include LocaleSelectable
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :user_ready?

  private
  def user_ready?
    return unless user_signed_in?
    redirect_to my_account_setup_path unless current_user.ready?
  end
end
