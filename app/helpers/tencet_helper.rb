module TencetHelper
  def getDate(post)
    @dayBeforePost = 0
    @dayBeforePost = (post.created_at - Time.now) / (60.0 * 60.0 * 24.0)
    @text = "Дней до публикации: "
    if @dayBeforePost < 0
      return ""
    elsif @dayBeforePost < 1
      return @text + "1"
    else
      return @text + (@dayBeforePost.round).to_s
    end
  end
end
