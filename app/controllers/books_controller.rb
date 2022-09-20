class BooksController < ApplicationController
  # meshiterroのpost_images_controller.rbからコピペして編集
  # ヘルパーメソッド
  before_action :authenticate_user!


  def new
    @book = Book.new
  end

   # 投稿データの保存
   # if式を用いて、対象のカラム（ここではimageとshop_name）にデータが保存された場合はsaveメソッド(@post_image.save)がtrueになり、
   # 今まで通りredirect_toによりリダイレクト処理が走りバリデーションなどにより保存できなかった場合はsaveメソッドがfalseになり、
   # renderによりpost_images/new.html.erbが表示され投稿ページを再表示するように設定します。
  def create
    @user = current_user
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:notice] = "You have created book successfully."
      redirect_to book_path(@book.id)
    else
      # 追加した行
      @books = Book.all

      render :index
    end
  end

  def edit
    # 編集したい本の情報
    @book = Book.find(params[:id])
    @books = Book.all
  end

  def update
    @book = Book.find(params[:id])
   if @book.update(book_params)
     flash[:notice] = "You have updated book successfully."
     redirect_to book_path(@book.id)
   else
     render :edit
   end
  end

  def index
      @book = Book.new
      @books = Book.all
  end

  def destroy
    # @book = 削除するBookレコードを取得
    @book = Book.find(params[:id])
    #  @book.削除
    @book.destroy
    # redirect_to Bookの一覧ページへのパス
    redirect_to books_path
  end

  def show
     @books = Book.all
     @book = Book.find(params[:id])
  end

  # 投稿データのストロングパラメータ
  private

  def book_params
    params.require(:book).permit(:title, :body)
  end
end
