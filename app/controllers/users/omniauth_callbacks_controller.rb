class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def google_oauth2
    @user = User.find_for_google_oauth2 request.env['omniauth.auth'], current_user

    if @user.persisted?
      @user.update_attribute :google_token, request.env['omniauth.auth'][:credentials][:token]
      flash[:notice] = I18n.t('devise.omniauth_callbacks.success', :kind => 'Google')

      sign_in_and_redirect @user, :event => :authentication
    else
      session['devise.google_data'] = request.env['omniauth.auth']
      
      redirect_to root_url
    end
  end

end
