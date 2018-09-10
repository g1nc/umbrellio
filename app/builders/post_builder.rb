class PostBuilder
  def initialize(title:, content:, login:, ip:)
    @title   = title
    @content = content
    @login   = login
    @ip      = ip
  end

  def inspect!
    invalid_fields = []
    invalid_fields << 'title'   unless @title.present?
    invalid_fields << 'content' unless @content.present?
    invalid_fields << 'login'   unless @login.present?
    invalid_fields << 'ip'      unless @ip.present?

    raise "Invalid #{invalid_fields.join(', ')}!" if invalid_fields.present?
  end

  def save
    user = User.find_or_create_by(login: @login)
    Post.create(
      user:    user,
      title:   @title,
      content: @content,
      ip:      @ip
    ).attributes
  end
end
