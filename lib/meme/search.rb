module Meme

  class Post

    VARS = ["category", "timestamp", "guid", "pubid", "url", "repost_count", "caption", "type", "content"]

    attr_accessor *VARS

    def initialize(data)
      unless data.nil?
        VARS.each do |var|
          self.instance_variable_set("@#{var}", data[var])
        end
      end      
    end

    def self.find(query, options = {})
      type  = " and type='#{options.delete(:type).to_s}'" if options.has_key?(:type)
      query = "SELECT * FROM meme.search WHERE query='#{query}'#{type}"
      parse = Request.parse(query)
      if parse
        results = parse['query']['results']
        results.nil? ? nil : results['post'].map {|m| Post.new(m)}
      else
        parse.error!
      end
    end

  end

end
