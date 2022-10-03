# frozen_string_literal: true

# main Model class
class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  private

  def hacker_news_client
    @hacker_news_client = HackerNews.new
  end

  def deleted_comment(params)
    params.merge(by: 'unknown', kids: [], text: '[deleted comment by user]')
  end
end
