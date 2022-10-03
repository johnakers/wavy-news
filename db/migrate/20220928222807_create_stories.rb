# migration for Story
class CreateStories < ActiveRecord::Migration[7.0]
  def change
    create_table :stories, id: false, primary_key: :id do |t|
      t.integer :id, null: false, unique: true, index: true

      t.string :by, null: false
      t.integer :descendants, null: false
      t.jsonb :kids, default: []
      t.integer :score, null: false
      t.string :title
      t.string :url
      t.datetime :time, null: false

      t.timestamps
    end
  end
end
