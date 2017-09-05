class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "User has been created"
      redirect_to login_path
    else
      flash.now[:danger] = "Invalid input"
      render :new
    end
  end

  def show
    @user_wish = @user.wishes.order("created_at DESC")
  end

  def edit
  end

  def update
    @user.update(update_params)
    if @user.save(validate: false)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      flash.now[:danger] = "Update failed"
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password)
  end

  def update_params
    params.require(:user).permit(:name, :email, :password)
  end
end
