require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe 'index' do
    it 'return users ips' do
      5.times { |_i| create(:post, ip: Faker::Internet.unique.ip_v4_address) }
      get :index, params: { user_ids: Post.first(3).pluck(:user_id).join(',') }
      expect(JSON.parse(response.body)['ips']).to be_kind_of(Array)
    end
  end
end
