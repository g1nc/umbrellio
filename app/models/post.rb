class Post < ApplicationRecord
  belongs_to :user
  has_many   :rates

  def update_rating(rate)
    update(
      rate_sum: rate_sum + rate,
      rate_count: rate_count + 1
    )
  end

  def rating
    return 0 if rate_count.zero?
    (rate_sum.to_f / rate_count).round(2)
  end

  def self.get_top(n)
    where('rate_count > 0')
      .select('id, title, content')
      .group('id')
      .order('avg((0.0 + rate_sum)/nullif(rate_count, 0)) desc')
      .limit(n)
  end
end
