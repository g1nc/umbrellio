require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  describe 'create' do
    let(:post_params) do
      {
        title:   Faker::Lorem.sentence,
        content: Faker::Lorem.paragraph,
        login:   create(:user).login,
        ip:      Faker::Internet.ip_v4_address,
      }
    end

    context 'error' do
      it 'status 422 and error' do
        post :create, params: post_params.merge(title: nil)
        expect(response.code).to eq('422')
        expect(response.body).to eq({ error: 'Invalid title!' }.to_json)
      end
    end

    context 'success' do
      it 'status 200 and post' do
        post :create, params: post_params
        expect(response.code).to eq('200')
        expect(response.body).to eq(Post.last.attributes.to_json)
      end
    end
  end

  describe 'top' do
    it 'return values' do
      post_1 = create(:post, rate_sum: 5, rate_count: 1)
      post_2 = create(:post, rate_sum: 4, rate_count: 1)
      post_3 = create(:post, rate_sum: 3, rate_count: 1)
      post_4 = create(:post, rate_sum: 2, rate_count: 1)
      post_5 = create(:post, rate_sum: 1, rate_count: 1)

      get :top, params: { count: 3}
      expect(JSON.parse(response.body)).to eq([
        {
          'id' => post_1.id,
          'title' => post_1.title,
          'content' => post_1.content
        },
        {
          'id' => post_2.id,
          'title' => post_2.title,
          'content' => post_2.content
        },
        {
          'id' => post_3.id,
          'title' => post_3.title,
          'content' => post_3.content
        }
      ])
    end
  end
end
