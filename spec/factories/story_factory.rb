# frozen_string_literal: true

# Story factory
FactoryBot.define do
  factory :story do
    id { 87_654_321 }
    by { 'john' }
    descendants { 1 }
    kids { [12_345_678] }
    score { 99 }
    title { 'This is a witty title for a Story' }
    url { 'https://github.com/johnakers' }
    time { DateTime.now }
  end
end
