class PostsController < ApplicationController

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
      # ログインユーザーのuser_idで投稿を作成
    tag_list = params[:post][:tag_name].split(" ")
      # formから@postオブジェクトを参照してtag_nameも送信
      # split(nil)もしくは(" ")→送信されてきた値をスペースで区切って配列化
    if @post.save
       @post.save_tag(tag_list)
        # @postに紐づくsave_tagメソッド（引数tag_list)
        # tag_listの配列を保存
        # save_tagインスタンスメソッド→Postモデルで定義をしたインスタンスメソッド
      redirect_to root_path
    else
      redirect_to root_path
    end
  end

  def index
    @post = Post.new
    @post.user_id = current_user.id
    @tag_list = Tag.all
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
    @post_tags = @post.tags
  end

  private

  def post_params
      params.require(:post).permit(:content)
  end

end
