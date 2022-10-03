      # t.belongs_to :story, null: false, index: true
      # t.belongs_to :parent

      # t.string :by, null: false
      # t.jsonb :kids, default: []
      # t.text :text
      # t.datetime :time, null: false
      # t.timestamps

# Comment Factory
FactoryBot.define do
  factory :comment do
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
