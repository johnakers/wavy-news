# frozen_string_literal: true

# model for Comment
class Comment < ApplicationRecord
  self.primary_key = :id

  belongs_to :story
  belongs_to :parent, class_name: 'Comment', optional: true
  has_many :comments, foreign_key: :parent_id

  def fetch_comments!
    kids.each do |child_id|
      comment_params = hacker_news_client.item(id: child_id)&.merge({ 'story_id' => story_id })

      next if comment_params.nil?
      comment_params = deleted_comment(comment_params) if comment_params['deleted']

      comments.create!(comment_params)
    end

    nil
  end
end
