require 'rails_helper'

RSpec.describe Rate, type: :model do
  describe '#update_post' do
    it 'update post rating' do
      post = create(:post, user: create(:user), rate_sum: 0, rate_count: 0)
      rate = Rate.create(post: post, value: 5)
      rate.update_post
      expect(post.reload.rating).to eq(5)
    end
  end
end
