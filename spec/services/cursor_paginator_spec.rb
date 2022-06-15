require 'rails_helper'

RSpec.describe('CursorPaginator', type: :service) do
  describe '#paginate' do
    before do
      30.times { create(:tweet) }
    end

    it 'paginates records successfully' do
      result = CursorPaginator.new(Tweet.all, nil).paginate

      expect(result[:page_info][:total]).to eq(Tweet.count)
      expect(result[:page_info][:has_previous_page]).to be_falsey
      expect(result[:page_info][:has_next_page]).to be_truthy
      expect(result[:page].size).to eq(10)
      expect(result[:page].first.id).to eq(Tweet.last.id)
    end

    it 'paginates tweets by cursor' do
      tweets = Tweet.order(created_at: :desc)
      result = CursorPaginator.new(Tweet.all, tweets[25].id).paginate

      expect(result[:page_info][:has_previous_page]).to be_truthy
      expect(result[:page_info][:has_next_page]).to be_falsey
      expect(result[:page].size).to eq(4)
      expect(result[:page].first.id).to eq(tweets[26].id)
    end
  end
end
