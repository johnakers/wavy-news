# frozen_string_literal: true

# controller for Comment
class CommentsController < ApplicationController
  def show
    return redirect_to root_path if story.nil?

    @comment = Comment.find_by(id: params[:id])

    @comment.fetch_comments! if @comment.kids.any? && @comment.comments.empty?

    redirect_to root_path if @comment.nil?
  end

  private

  def story
    @story ||= Story.find_by(id: params[:story_id])
  end
end
