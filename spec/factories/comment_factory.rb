# frozen_string_literal: true

# Comment Factory
FactoryBot.define do
  factory :comment do
    # story_id
    # parent_id

    id { 12_345_678 }
    by { 'another_user' }
    kids { [] }
    text { 'This is a snarky comment' }
    time { DateTime.now }
    deleted { false }
  end
end
