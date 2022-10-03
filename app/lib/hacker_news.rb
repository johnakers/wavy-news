# frozen_string_literal: true

# Notes:
# -- Deleted example
# { "deleted"=>true, "id"=>33062875, "parent"=>33062846, "time"=>1664764454, "type"=>"comment"}

# module to interact with HackerNews Api
class HackerNews
  include HTTParty
  base_uri 'https://hacker-news.firebaseio.com/v0'

  # returns ids of top 10 stories
  def top_stories
    self.class.get('/topstories.json')
  end

  # returns item body, or nil
  def item(id: nil)
    raise 'No :id provided' if id.nil?

    json = self.class.get("/item/#{id}.json")
    response = HackerNewsResponse.new(json)

    return nil if response.invalid_type?

    response.parsed_body
  end

  # class for HackerNews responses
  class HackerNewsResponse
    VALID_PARAMS = {
      'story' => %w[id by descendants kids score title url time],
      'comment' => %w[id by kids parent text time deleted]
    }.freeze

    attr_reader :params

    def initialize(params)
      @params = params
    end

    # only doing Stories and Comments, for now
    # "Job" is not valid
    def invalid_type?
      !story? && !comment?
    end

    # mapped body based on type
    def parsed_body
      output = params.slice(*VALID_PARAMS[type])
      output['time'] = Time.at(output['time']).to_datetime # time comes in as epoch

      return output if story?

      output['parent_id'] = output.delete('parent')
      output
    end

    private

    def type
      params['type']
    end

    def story?
      type == 'story'
    end

    def comment?
      type == 'comment'
    end
  end
end

# Another pattern I like leveraging is:

# class HackerNews
#   def self.top_stories
#     HackerNews.new.top_stories
#   end

#   def self.item(id: nil)
#     HackerNews.new.item(id: id)
#   end

#   def top_stories
#     # code ...
#   end

#   def self.item
#     # code ...
#   end
# end

