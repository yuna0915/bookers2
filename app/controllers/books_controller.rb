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
    @books = Book.where(user_id: @book.user_id) 
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id

    if @book.save
      flash[:notice] = "You have created book successfully."
      redirect_to @book
    else
      render :index
    end
  end

  def edit
  end

  def update
    @book = Book.find(params[:id])  
    if @book.update(book_params)  
      flash[:notice] = "You have updated the book successfully."
      redirect_to @book
    else
      render :edit
    end
  end  

  def destroy
    @book.destroy
    flash[:notice] = "You have deleted the book successfully."
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
    if @book.user != current_user
      flash[:alert] = "権限がありません。"
      redirect_to books_path
    end
  end
end
