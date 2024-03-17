class BooksController < ApplicationController
  before_action :is_matchig_login_user, only:[:edit, :update]
  def new
    @new_book = Book.new
  end

  def index
    @books = Book.all
    @new_book = Book.new
    @users = User.all
    @user = current_user
  end

  def show
    @book = Book.find(params[:id])
    @user = User.find(@book.user_id)
    @new_book = Book.new
  end

  def create
    @new_book = Book.new(book_params)
    @new_book.user_id = current_user.id
    if @new_book.save
      flash[:notice] = "You have created book successfully"
      redirect_to book_path(@new_book)
    else
      @books = Book.all
      @users = User.all
      @user = current_user
      render :index
    end
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
    flash[:notice] = "You have updated book successfully"
    redirect_to book_path(@book.id)
    else
      render :edit
    end
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to '/books'
  end

  private
  def book_params
    params.require(:book).permit(:title, :body)
  end

  def is_matchig_login_user
    @book = Book.find(params[:id])
    user_id = @book.user.id
    login_user_id = current_user.id
    if(user_id != login_user_id)
      redirect_to books_path
    end
  end
end
