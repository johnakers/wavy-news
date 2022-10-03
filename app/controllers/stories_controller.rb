# frozen_string_literal: true

# Controller for Stories
class StoriesController < ApplicationController
  def index
    @stories = Story.all
  end

  def show
    return redirect_to root_path if story.nil?

    story.fetch_comments! if story.unfectched_comments?
  end

  private

  def story
    @story ||= Story.includes(:comments).find_by(id: params[:id])
  end
end
