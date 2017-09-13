class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(email: params[:email])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      flash[:success] = "Signed in!"
      redirect_to user_wishes_path(user_id: @user.id)
    else
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:danger] = "Signed out!"
    redirect_to login_path
  end

  def create_from_omniauth
    auth_hash = request.env["omniauth.auth"]
    authentication = Authentication.find_by_provider_and_uid(auth_hash["provider"], auth_hash["uid"]) || Authentication.create_with_omniauth(auth_hash)
    if authentication.user
      user = authentication.user
      authentication.update_token(auth_hash)
      flash[:success] = "Signed in!"
    else
      user = User.create_with_auth_and_hash(authentication, auth_hash)
      flash[:info] = "User created - confirm or edit details..."
    end
    session[:user] = user.id
    redirect_to user_wishes_path(user_id: @user.id)
  end
end
