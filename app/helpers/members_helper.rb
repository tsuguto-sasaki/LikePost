module MembersHelper
  def gravatar_url(member, options = { size: 80 })
    gravatar_id = Digest::MD5::hexdigest(member.email.downcase)
    size = options[:size]
    "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
  end
end
