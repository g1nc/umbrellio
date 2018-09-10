class Rate < ApplicationRecord
  belongs_to :user
  belongs_to :post

  def update_post
    post.update_rating(value)
  end
end
