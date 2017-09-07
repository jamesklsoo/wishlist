class WishesController < ApplicationController
  before_action :set_wish, only: [:show, :edit, :update, :destroy]

  def index
    @wishes = Wish.all
  end

  def show
  end

  def new
    @wish = Wish.new
  end

  def edit
  end

  def create
    @wish = Wish.new(wish_params)
    @wish.user_id = current_user.id
    if @wish.save
      flash[:success] = "Wish has been created."
      redirect_to wish_path(@wish)
    else
      flash[:danger] = "There has been an error."
      render :new
    end
  end

  def update
    @wish.update(wish_params)
    if @wish.save
      flash[:success] = "Wish updated."
    else
      flash[:danger] = "Update failed."
      render :edit
    end

  end

  def destroy
    @wish.destroy
    respond_to do |format|
      format.html { redirect_to wishes_url, notice: 'Wish was successfully destroyed.'}
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
