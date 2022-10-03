# frozen_string_literal: true

# class for Story
class Story < ApplicationRecord
  self.primary_key = :id

  has_many :comments

  def fetch_comments!
    kids.each do |child_id|
      comment_params = hacker_news_client.item(id: child_id)
      comment_params['parent_id'] = nil

      comment_params = deleted_comment(comment_params) if comment_params['deleted']

      comments.create!(comment_params)
    end

    nil
  end
end
