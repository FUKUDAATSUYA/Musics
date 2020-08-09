class Music < ApplicationRecord
 belongs_to :user
  has_many :favorites
  has_many :favorite_users, through: :favorites, source: :user
  has_many :music_comments, dependent: :destroy
  has_many :notifications, dependent: :destroy

  # バリデーションは該当するモデルに設定する。エラーにする条件を設定できる。
  # presence trueは空欄の場合を意味する。
  validates :title, presence: true
  validates :body, presence: true, length: { maximum: 200 }

  def create_notification_by(current_user)
        notification = current_user.active_notifications.new(
          music_id: id,
          visited_id: user_id,
          action: "favolite"
        )
        notification.save if notification.valid?
    end

 def create_notification_comment!(current_user, music_comment_id)
    # 自分以外にコメントしている人をすべて取得し、全員に通知を送る
    temp_ids = MusicComment.select(:user_id).where(music_id: id).where.not(user_id: current_user.id).distinct
    temp_ids.each do |temp_id|
    save_notification_comment!(current_user, music_comment_id, temp_id['user_id'])
    end
    # まだ誰もコメントしていない場合は、投稿者に通知を送る
    save_notification_comment!(current_user, music_comment_id, user_id) if temp_ids.blank?
  end

  def save_notification_comment!(current_user, music_comment_id, visited_id)
    # コメントは複数回することが考えられるため、１つの投稿に複数回通知する
    notification = current_user.active_notifications.new(
      music_id: id,
      music_comment_id: music_comment_id,
      visited_id: visited_id,
      action: 'music_comment'
    )
    # 自分の投稿に対するコメントの場合は、通知済みとする
    if notification.visitor_id == notification.visited_id
      notification.checked = true
    end
    notification.save if notification.valid?
  end
end
