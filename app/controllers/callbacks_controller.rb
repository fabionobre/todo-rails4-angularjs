class CallbacksController < Devise::OmniauthCallbacksController
    
  def all

    @user = User.from_omniauth(request.env["omniauth.auth"])

    if @user.persisted?
      flash[:notice] = "Signed in successfully."
      sign_in_and_redirect(@user)
    else
      redirect_to new_user_registration_url
    end
  end

  def failure
    redirect_to root_path
  end

	alias_method :facebook, :all
	alias_method :google_oauth2, :all
end