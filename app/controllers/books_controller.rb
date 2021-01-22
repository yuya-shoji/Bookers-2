class BooksController < ApplicationController
 before_action :authenticate_user!
 before_action :ensure_current_user, {only: [:edit, :update, :destroy]}

     def index
     @user = current_user
     @books = Book.all
     @book = Book.new
     end

     def show
     @user = current_user
     @book_new = Book.new
     @book = Book.find(params[:id])
     end

    def create
     @user = current_user
     @book = Book.new(book_params)
     @book.user_id = current_user.id
     if @book.save
      flash[:notice] = "You have created book successfully."
      redirect_to book_path(@book.id)
     else
      @books = Book.all
      @user = current_user
      render "index"
     end
    end

    def edit
       @book = Book.find(params[:id])
    end


   def update
       @book = Book.find(params[:id])
       if @book.update(book_params)
       flash[:notice] = "You have updated book successfully."
       redirect_to  book_path(@book.id)
       else
       @books = Book.all
       render "edit"
       end
   end

   def destroy
       @book = Book.find(params[:id])
       @book.destroy
       redirect_to books_path
   end

     private
     def book_params
      params.require(:book).permit(:title, :body)
     end

     def ensure_current_user
      @book = Book.find(params[:id])
      if @book.user_id != current_user.id
       redirect_to books_path
      end
     end
end
