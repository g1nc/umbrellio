# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RateBuilder do
  let(:post) { create(:post) }
  let(:rate_params) do
    {
      post_id: post.id,
      value:   5
    }
  end

  subject { RateBuilder }

  describe '#inspect!' do
    context 'invalid params' do
      it 'inspect post_id' do
        builder = subject.new(rate_params.merge(post_id: nil))
        expect { builder.inspect! }.to raise_error(RuntimeError, "Invalid post_id!")
      end

      it 'inspect value' do
        builder = subject.new(rate_params.merge(value: nil))
        expect { builder.inspect! }.to raise_error("Invalid value!")
        builder = subject.new(rate_params.merge(value: 6))
        expect { builder.inspect! }.to raise_error("Invalid value!")
      end

      it 'few fields error' do
        builder = subject.new(post_id: nil, value: nil)
        expect { builder.inspect! }.to raise_error("Invalid post_id, value!")
      end
    end

    context 'valid params' do
      it 'not raise error' do
        expect { subject.new(rate_params).inspect! }.not_to raise_error
      end
    end
  end

  describe '#save' do
    context 'post not exists' do
      it 'raise error' do
        builder = subject.new(rate_params.merge(post_id: 0))
        expect { builder.save }.to raise_error("Invalid post_id!")
      end
    end

    context 'update post rate' do
      it 'return avg' do
        post.update(
          rate_sum: 6,
          rate_count: 2
        )
        builder = subject.new(rate_params)
        expect(builder.save).to eq(rating: 3.67)
      end
    end
  end
end
