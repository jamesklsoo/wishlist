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
end
