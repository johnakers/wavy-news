# frozen_string_literal: true

namespace :stories do
  desc 'repopulate top 10 stories'
  task :repopulate_top10_stories => :environment do
    Rails.logger.info("Destroying #{Comment.count} Comments")
    Comment.destroy_all
    Rails.logger.info("Destroying #{Story.count} Stories")
    Story.destroy_all

    hn = HackerNews.new

    hn.top_stories.each do |id|
      story_params = hn.item(id: id)

      next if story_params.nil?

      Story.create!(story_params)

      # this exists as we want to keep pulling ids til we get 10 stories, not jobs, or other types
      break if Story.count == 10
    end

    Rails.logger.info('Stories created')
  end
end
