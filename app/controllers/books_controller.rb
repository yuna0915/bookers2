class BooksController < ApplicationController
  before_action :set_book, only: [:show, :edit, :update, :destroy]
  before_action :ensure_correct_book, only: [:update, :edit, :destroy]

  def index
    @books = Book.all
    @book = Book.new 
  end

  def show
    @user = @book.user
    @newbook = Book.new
  end

  def create
    @book = current_user.books.build(book_params) 
    if @book.save
      redirect_to @book, notice: "You have created a book successfully."
    else
      @books = Book.all
      render :index
    end
  end

  def edit
    # before_actionでset_bookメソッドを実行しているため不要
  end

  def update
    if @book.update(book_params)
      redirect_to @book, notice: "You have updated the book successfully."
    else
      render :edit
    end
  end

  def destroy
    @book.destroy
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end

  def set_book
    @book = Book.find(params[:id])
  end

  def ensure_correct_book
    unless @book.user == current_user
      redirect_to books_path, alert: "You are not authorized to perform this action."
    end
  end
end
