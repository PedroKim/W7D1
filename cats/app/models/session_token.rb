# == Schema Information
#
# Table name: session_tokens
#
#  id            :integer          not null, primary key
#  session_token :string           not null
#  user_id       :integer          not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class SessionToken < ApplicationRecord
    validates :session_token, presence: true, uniqueness: true

    belongs_to :user
end
