class Tweet < ApplicationRecord
  belongs_to :user

  scope :by_user, lambda { |user_id|
    next if user_id.blank?

    where(user_id: user_id)
  }
end
