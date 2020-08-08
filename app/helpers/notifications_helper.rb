module NotificationsHelper

  def notification_form(notification)
      @visitor = notification.visitor
      @music_comment = nil
      your_music = link_to 'あなたの投稿', musics_path(notification), style:"font-weight: bold;"
      @visitor_music_comment = notification.music_comment_id
      #notification.actionがfollowかlikeかcommentか
      case notification.action
        when "follow" then
          tag.a(notification.visitor.name, href:users_path(@visitor), style:"font-weight: bold;")+"があなたをフォローしました"
        when "favolite" then
          tag.a(notification.visitor.name, href:users_path(@visitor), style:"font-weight: bold;")+"が"+tag.a('あなたの投稿', href:musics_path(notification.music_id), style:"font-weight: bold;")+"にいいねしました"
        when "music_comment" then
            @music_comment = MusicComment.find_by(id: @visitor_music_comment)&.content
            tag.a(@visitor.name, href:users_path(@visitor), style:"font-weight: bold;")+"が"+tag.a('あなたの投稿', href:musics_path(notification.music_id), style:"font-weight: bold;")+"にコメントしました"
      end
  end

  def unchecked_notifications
      @notifications = current_user.passive_notifications.where(checked: false)
  end

end
