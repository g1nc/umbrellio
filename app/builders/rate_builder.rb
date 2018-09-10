class RateBuilder
  def initialize(post_id:, value:)
    @post_id = post_id
    @value   = value
  end

  def inspect!
    invalid_fields = []
    invalid_fields << 'post_id' unless @post_id.present?
    invalid_fields << 'value'   unless @value.present? && (1..5).include?(@value.to_i)

    raise "Invalid #{invalid_fields.join(', ')}!" if invalid_fields.present?
  end

  def save
    rate = Rate.create(
      post: Post.find(@post_id),
      value: @value
    )
    rate.update_post
    { rating: rate.post.rating }
  rescue ActiveRecord::RecordNotFound => exc
    raise "Invalid post_id!"
  end
end
