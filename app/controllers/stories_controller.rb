# frozen_string_literal: true

# Controller for Stories
class StoriesController < ApplicationController
  def index
    @stories = Story.all
  end

  def show
    @story = Story.includes(:comments).find_by(id: params[:id])

    return redirect_to root_path if @story.nil?

    @story.fetch_comments! if @story.kids.any? && @story.comments.empty?
  end
end
