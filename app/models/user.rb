class User < ApplicationRecord
  belongs_to :company
  has_many :tweets

  scope :by_company, lambda { |company_id|
    next if company_id.blank?

    where(company_id: company_id)
  }

  scope :by_username, lambda { |username|
    next if username.blank?

    where('username LIKE ?', "%#{username}%")
  }
end
