module Meme

  class Post

    VARS = ["category", "timestamp", "guid", "pubid", "url", "repost_count", "caption", "type", "content"] #:nodoc:

    attr_accessor *VARS

    def initialize(data) #:nodoc:
      unless data.nil?
        VARS.each do |var|
          self.instance_variable_set("@#{var}", data[var])
        end
      end      
    end

    # Find posts
    #
    #   Example:
    #
    #   # type text
    #   posts = Meme::Post.find('brhackday')
    #
    #   # type photo
    #   posts = Meme::Post.find('brhackday', :type => :photo)
    #
    #   # type video
    #   posts = Meme::Post.find('brhackday', :type => :video)
    #
    #   posts.first.content
    #   => "RT @codepo8: And I am off - plane leaves BR for London. Thanks to everybody...
    #
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
