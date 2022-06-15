require 'rails_helper'

RSpec.describe(User, type: :model) do
  context 'Scopes' do
    describe 'by_username' do
      let(:user) { create(:user, username: 'first') }
      let(:other_user) { create(:user, username: 'second') }

      it 'filters the user by username' do
        result = User.by_username('irst')
        expect(result).to include(user)
        expect(result).not_to include(other_user)
      end
    end

    describe 'by_company' do
      let(:company)      { create(:company) }
      let(:company_user) { create(:user, company: company) }
      let(:other_user)   { create(:user) }

      it 'filters users by company id' do
        records = User.by_company(company.id)

        expect(records).to include(company_user)
        expect(records).not_to include(other_user)
      end
    end
  end
end
