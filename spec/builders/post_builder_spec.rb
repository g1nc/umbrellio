# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PostBuilder do
  let(:post_params) do
    {
      title:   Faker::Lorem.sentence,
      content: Faker::Lorem.paragraph,
      login:   'test_login',
      ip:      Faker::Internet.ip_v4_address,
    }
  end

  subject { PostBuilder }

  describe '#inspect!' do
    context 'invalid params' do
      it 'inspect titile' do
        builder = subject.new(post_params.merge(title: nil))
        expect { builder.inspect! }.to raise_error(RuntimeError, "Invalid title!")
      end

      it 'inspect content' do
        builder = subject.new(post_params.merge(content: nil))
        expect { builder.inspect! }.to raise_error("Invalid content!")
      end

      it 'inspect login' do
        builder = subject.new(post_params.merge(login: nil))
        expect { builder.inspect! }.to raise_error("Invalid login!")
      end

      it 'inspect ip' do
        builder = subject.new(post_params.merge(ip: nil))
        expect { builder.inspect! }.to raise_error("Invalid ip!")
      end

      it 'few fields error' do
        builder = subject.new(title: nil, content: nil, login: nil, ip: nil)
        expect { builder.inspect! }.to raise_error("Invalid title, content, login, ip!")
      end
    end

    context 'valid params' do
      it 'not raise error' do
        expect { subject.new(post_params).inspect! }.not_to raise_error
      end
    end
  end

  describe '#save' do
    context 'existing user' do
      it 'fetch user' do
        user = create(:user)
        expect { subject.new(post_params.merge(login: user.login)).save }.not_to change { User.count }
        post = Post.last
        expect(post.user).to    eq(user)
        expect(post.title).to   eq(post_params[:title])
        expect(post.content).to eq(post_params[:content])
        expect(post.ip).to      eq(post_params[:ip])
      end
    end

    context 'new user' do
      it 'create user' do
        expect { subject.new(post_params).save }.to change { User.count }.by(1)
        post = Post.last
        expect(post.title).to   eq(post_params[:title])
        expect(post.content).to eq(post_params[:content])
        expect(post.ip).to      eq(post_params[:ip])
      end
    end
  end
end
