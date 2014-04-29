class AuthenticationsController < Devise::OmniauthCallbacksController
  skip_before_action :verify_authenticity_token
  Connection::PROVIDERS.each do|provider|
    define_method provider.to_s do
      @user = User.authentication(env['omniauth.auth'], current_user)
      if @user.try(:persisted?)
        sign_in(@user)
        flash[:notice] = t('devise.omniauth_callbacks.success', kind: provider)
        redirect_to authenticated_user_root_path
      else
        flash[:notice] = t('devise.omniauth_callbacks.failure', kind: provider, reason: 'User create error')
        redirect_to root_path
      end
    end
  end

  def failure
    redirect_to request.env['omniauth.origin'] || root_path
  end
end
