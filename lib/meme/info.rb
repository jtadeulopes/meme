module Meme

  class Info

    VARS = ["avatar_url", "name", "title", "guid", "language", "url", "description"] #:nodoc:

    attr_accessor *VARS

    def initialize(data) #:nodoc:
      unless data.nil?
        VARS.each do |var|
          self.instance_variable_set("@#{var}", data[var])
        end
      end
    end

    # Find user
    #
    #   Example:
    #
    #   # by name
    #   user = Meme::Info.find('jtadeulopes')
    #   user.name
    #   => "jtadeulopes"
    #
    def self.find(name)
      query = "SELECT * FROM meme.info WHERE name='#{name}'"
      parse = Request.parse(query)
      if parse
        results = parse['query']['results']
        results.nil? ? nil : Info.new(results['meme'])
      else
        parse.error!
      end
    end

    # Find user by guid
    #
    #   Example:
    #
    #   user = Meme::Info.find_by_guid('EMREXCV4R5OTM3CZW3HBD5QAGY')
    #
    def self.find_by_guid(name)
      query = "SELECT * FROM meme.info WHERE owner_guid='#{name}'"
      parse = Request.parse(query)
      if parse
        results = parse['query']['results']
        results.nil? ? nil : Info.new(results['meme'])
      else
        parse.error!
      end
    end

    # Return user followers
    #
    #   Example:
    #
    #   # Search user
    #   user = Meme::Info.find('jtadeulopes')
    #
    #   # Default
    #   followers = user.followers
    #   followers.count
    #   => 10
    #
    #   # Specify a count
    #   followers = user.followers(100)
    #   followers.count
    #   => 100
    #
    #   # All followers
    #   followers = user.followers(:all)
    #   followers.count
    #
    #   follower = followers.first
    #   follower.name
    #   => "zigotto"
    #   follower.url
    #   => "http://meme.yahoo.com/zigotto/"
    #
    def followers(count=10)
      count = 0 if count.is_a?(Symbol) && count == :all
      query = "SELECT * FROM meme.followers(#{count}) WHERE owner_guid='#{self.guid}'"
      parse = Request.parse(query)
      if parse
        results = parse['query']['results']
        results.nil? ? nil : results['meme'].map {|m| Info.new(m)}
      else
        parse.error!
      end
    end

    # Return user following
    #
    #   Example:
    #
    #   # Search user
    #   user = Meme::Info.find('jtadeulopes')
    #
    #   # Default
    #   following = user.following
    #   following.count
    #   => 10
    #
    #   # Specify a count
    #   following = user.following(100)
    #   following.count
    #   => 100
    #
    #   # All following
    #   following = user.following(:all)
    #   following.count
    #
    def following(count=10)
      count = 0 if count.is_a?(Symbol) && count == :all
      query = "SELECT * FROM meme.following(#{count}) WHERE owner_guid='#{self.guid}'"
      parse = Request.parse(query)
      if parse
        results = parse['query']['results']
        results.nil? ? nil : results['meme'].map {|m| Info.new(m)}
      else
        parse.error!
      end
    end

  end

end
