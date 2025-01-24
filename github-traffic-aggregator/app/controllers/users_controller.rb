class UsersController < ApplicationController

  def index
    # Get all users
    @users = User.all
  end

  def show
    # Get the user
    @user = User.find(params[:id])
    @repos = Repo.where(user: @user)  
  end
  

  def new
  end

  def edit
  end
end
