module Meme

  class Info

    VARS = ["avatar_url", "name", "title", "guid", "followers", "language", "url", "description"]

    attr_accessor *VARS

    def initialize(data)
      unless data.nil?
        VARS.each do |var|
          self.instance_variable_set("@#{var}", data[var])
        end
      end
    end

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

  end

end
