module GravatarHelper
  def gravatar_url(email, size = 0)
    gravatar_id = Digest::MD5::hexdigest(email).downcase
    url = "http://gravatar.com/avatar/#{gravatar_id}.png?s=#{size}"
  end
end