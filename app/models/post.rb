class Post < ApplicationRecord
  belongs_to :user

  has_many :tag_maps, dependent: :destroy
  has_many :tags, through: :tag_maps

  # throuth オプションによってtag_mapsを通してtagsとの関連づけを行う
  # →Post.tagsとすればPostに紐づけられたTagが取得できる
  # 中間テーブルにdependent　destroyをつけることでPost削除と同時にTagの削除ができる
  # ＜注意！！！＞throughオプションを使う場合、先に中間テーブルとの関連づけを行う必要がある








  # postsコントローラで使うためsave_tagインスタンスメソッド作成
  
def save_tag(sent_tags)
    current_tags = self.tags.pluck(:tag_name) unless self.tags.nil?
     #self.tags存在しているか？
     # current_tags = self.tags.pluck(:tag_name)
     # createで保存した@postに紐づいているタグが存在する場合、「タグの名前を配列として」全て取得
     # plunk→特定のカラムの値だけ
     # self→オブジェクトを指す特殊変数→postに紐づくタグ（Post自身）
     # self無いとエラーになることもある・・・
     
     
    old_tags = current_tags - sent_tags
    # 現在取得した@postに存在するタグから新たに送信されてきたタグを除いたタグをold_tags
    new_tags = sent_tags - current_tags
    # 送られてきたタグから現在存在するタグを除いたタグをnew_tags
    
    
    old_tags.each do |old|
      self.tags.delete Tag.find_by(tag_name: old)
      # old_tagsをひとつづつ取り出し
      # find_or_delete_byはメソッドないためつかえない
      # 古いタグを削除
    end
    
    new_tags.each do |new|
      new_post_tag = Tag.find_or_create_by(tag_name: new)
      # 新しいタグをひとつづつ取り出してデータベースに保存
      self.tags << new_post_tag
      # 左辺と右辺を連結(非同期で使える)
      # << 後ろに追加
    end
end

end
