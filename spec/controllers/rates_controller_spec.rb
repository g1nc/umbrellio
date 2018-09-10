require 'rails_helper'

RSpec.describe RatesController, type: :controller do
  describe 'create' do
    let(:rate_params) do
      {
        post_id: create(:post).id,
        value:   5
      }
    end

    context 'error' do
      it 'validation error' do
        post :create, params: rate_params.merge(value: ' ')
        expect(response.code).to eq('422')
        expect(response.body).to eq({ error: 'Invalid value!' }.to_json)
      end

      it 'invalid post_id' do
        post :create, params: rate_params.merge(post_id: 0)
        expect(response.code).to eq('422')
        expect(response.body).to eq({ error: 'Invalid post_id!' }.to_json)
      end
    end

    context 'success' do
      it 'return rating' do
        test_post = create(:post)
        test_post.update(
          rate_sum: 10,
          rate_count: 2
        )
        post :create, params: rate_params.merge(post_id: test_post.id)
        expect(response.code).to eq('200')
        expect(response.body).to eq({ rating: 5.0 }.to_json)
      end
    end
  end
end
