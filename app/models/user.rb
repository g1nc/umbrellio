class User < ApplicationRecord
  has_many :posts
  has_many :rates

  def self.users_ip(user_ids)
    Post.joins(:user)
      .where('posts.user_id IN (?)', user_ids)
      .group('users.login')
      .group('posts.ip')
      .order('users.login, posts.ip')
      .pluck('posts.ip')
  end
end
