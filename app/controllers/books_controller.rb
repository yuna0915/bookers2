class BooksController < ApplicationController
  before_action :set_book, only: [:show, :edit, :update, :destroy]
  before_action :ensure_correct_book, only: [:update, :edit, :destroy]

  def index
    @book = Book.new 
    @books = Book.all
  end

  def show
    @user = @book.user
    @newbook = Book.new
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      redirect_to @book, notice: "You have created book successfully."
    else
      @books = Book.all
      render "index"
    end
  end

  def edit
  end

  def update
    if @book.update(book_params)
      redirect_to book_path(@book), notice: "You have updated book successfully."
    else
      render "edit"
    end
  end

  def destroy
    @book.destroy
    redirect_to books_path, notice: "You have deleted the book successfully."
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end

  def set_book
    @book = Book.find(params[:id])
  end

  def ensure_correct_book
    if @book.user != current_user
      flash[:alert] = "権限がありません。"
      redirect_to books_path
    end
  end
end
