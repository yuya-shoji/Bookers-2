class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_current_user, {only: [:edit,:update,:destroy]}

  def index
    @users = User.all
    @user = current_user
    @book = Book.new
  end

  def show
    @user = User.find(params[:id])
    @books = @user.books.all
    @book =Book.new
  end

  def create
    if @users.save
    flash[:notice] = "successfully"
      redirect_to users_path
    else
      render :show
    end
  end

  def edit
    @user = User.find(params[:id])
    if @user.id != current_user.id
      redirect_to user_path(@current_user.id)
    else
      render :edit
    end
  end


  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
    flash[:notice] = "successfully"
      redirect_to user_path(@user.id)
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end

  def ensure_current_user
    @user = User.find(params[:id])
    if @user.id != current_user.id
      redirect_to user_path(current_user.id)
    end
  end
end