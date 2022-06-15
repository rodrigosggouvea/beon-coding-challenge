require 'rails_helper'

RSpec.describe('Tweets', type: :request) do
  RSpec.shared_context('with multiple users') do
    let!(:first_user) { create(:user) }
    let!(:second_user) { create(:user) }

    before do
      15.times do
        create(:tweet, user: first_user)
      end
      15.times do
        create(:tweet, user: second_user)
      end
    end
  end

  describe '#index' do
    let(:result) { JSON.parse(response.body) }
    include_context 'with multiple users'

    context 'when fetching all tweets' do
      it 'returns 10 most recent tweets if no cursor is given' do
        get tweets_path

        expect(result['page'].size).to eq(10)
        expect(result['page'].first['id']).to eq(Tweet.last.id)
      end
    end

    context 'when fetching single user tweets' do
      it 'filters tweets by users' do
        get tweets_path(user_id: first_user.id)

        expect(result['page'].first['id']).to eq(first_user.tweets.last.id)
        expect(result['page'].map { |tweet| tweet['id'] }).not_to include(second_user.tweets.last.id)
      end
    end
  end
end
