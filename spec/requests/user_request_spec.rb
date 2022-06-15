require 'rails_helper'

RSpec.describe('Users', type: :request) do
  RSpec.shared_context('with multiple companies') do
    let!(:first_company) { create(:company) }
    let!(:second_company) { create(:company) }

    before do
      5.times do
        create(:user, company: first_company)
      end
      5.times do
        create(:user, company: second_company)
      end
    end
  end

  describe '#index' do
    let(:result) { JSON.parse(response.body) }

    context 'when fetching users by company' do
      include_context 'with multiple companies'
      let(:one_user)   { first_company.users.first }
      let(:other_user) { first_company.users.last }

      it 'returns only the users for the specified company' do
        get company_users_path(first_company)

        expect(result.size).to eq(first_company.users.size)
        expect(result.map { |element| element['id'] }).to eq(first_company.users.ids)
      end

      it 'filters the user by username if an username is specified' do
        get company_users_path(first_company, username: one_user.username)
        response_ids = result.map { |element| element['id'] }

        expect(response_ids).to include(one_user.id)
        expect(response_ids).not_to include(other_user.id)
      end
    end
  end
end
