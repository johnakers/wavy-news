# frozen_string_literal: true

# migration for Comments
class CreateComments < ActiveRecord::Migration[7.0]
  def change
    create_table :comments, id: false, primary_key: :id do |t|
      t.belongs_to :story, null: false, index: true
      t.references :parent

      t.integer :id, null: false, unique: true, index: true

      t.boolean :deleted, default: false
      t.string :by, null: false
      t.jsonb :kids, default: []
      t.text :text
      t.datetime :time, null: false
      t.timestamps
    end
  end
end
