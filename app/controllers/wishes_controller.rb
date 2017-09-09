class WishesController < ApplicationController
  before_action :set_wish, only: [:show, :edit, :update, :destroy]

  def index
    @wishes = Wish.search(params[:search])
    @user = User.all
  end

  def show
    @user = User.find(params[:user_id])
  end

  def new
    @wish = Wish.new
    @user = User.find(params[:user_id])
  end

  def edit
    @user = User.find(params[:user_id])
  end

  def create
    @wish = Wish.new(wish_params)
    @wish.user_id = current_user.id
    if @wish.save
      flash[:success] = "Wish has been created."
      redirect_to user_wish_path(current_user, @wish)
    else
      flash[:danger] = "There has been an error."
      render :new
    end
  end

  def update
    @wish.update(wish_params)
    if @wish.save
      flash[:success] = "Wish updated."
      redirect_to user_wish_path(current_user, @wish)
    else
      flash[:danger] = "Update failed."
      render :edit
    end

  end

  def destroy
    @wish.destroy
    respond_to do |format|
      format.html { redirect_to user_wishes_url, notice: 'Wish was successfully destroyed.'}
      format.json { head :no_content}
    end
  end

  private

  def set_wish
    @wish = Wish.find(params[:id])
  end

  def wish_params
    params.require(:wish).permit(:name, :description, :picture)
  end

end
