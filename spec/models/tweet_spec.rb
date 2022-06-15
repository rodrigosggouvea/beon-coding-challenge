require 'rails_helper'

RSpec.describe(Tweet, type: :model) do
  context 'Scopes' do
    describe 'by_user' do
      let(:user)        { create(:user) }
      let(:user_tweet)  { create(:tweet, user: user) }
      let(:other_tweet) { create(:tweet) }

      it 'filters tweets by user id' do
        records = Tweet.by_user(user.id)

        expect(records).to include(user_tweet)
        expect(records).not_to include(other_tweet)
      end
    end
  end
end
