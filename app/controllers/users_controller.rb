class UsersController < ApplicationController
  before_action :is_matching_login_user, only: [:edit, :update]

  def show
    @user = User.find(params[:id])
    @books = @user.books
    @new_book = Book.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
    flash[:notice] ="You have update user successfully"
    redirect_to user_path(@user.id)
    else
    render :edit
    end
  end

  def index
    @users = User.all
    @new_book = Book.new
    @user = current_user
  end

  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end

  def is_matching_login_user
    @user = User.find(params[:id])
    user_id = @user.id
    login_user_id = current_user.id
    if(user_id != login_user_id)
      redirect_to user_path(current_user)
    end
  end
end
