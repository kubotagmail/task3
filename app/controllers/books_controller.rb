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
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      redirect_to book_path(@book.id)
    else
      render :index
    end

  end

  def index
      @book = Book.new
      @books = Book.all
  end


  # 投稿データのストロングパラメータ
  private

  def book_params
    params.require(:book).permit(:title, :body)
  end
end
