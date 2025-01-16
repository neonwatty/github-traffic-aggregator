class UsersController < ApplicationController

  def index
    # Get all users
    @users = User.all
  end

  def show
    # Get the user
    @user = User.find(params[:id])
  end

  def new
  end

  def edit
  end
end
