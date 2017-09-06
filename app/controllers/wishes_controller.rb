class WishesController < ApplicationController
  before_filer :authorize
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
  end

  def update
  end


end
