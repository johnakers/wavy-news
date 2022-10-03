# frozen_string_literal: true

# controller for Comment
class CommentsController < ApplicationController
  def show
    return redirect_to root_path if story.nil? || comment.nil?

    comment.fetch_comments! if comment.unfectched_comments?
  end

  private

  def story
    @story ||= Story.find_by(id: params[:story_id])
  end

  def comment
    @comment ||= Comment.find_by(id: params[:id])
  end
end
