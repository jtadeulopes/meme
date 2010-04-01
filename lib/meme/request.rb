module Meme

  class Request #:nodoc:

    def self.parse(query)
      url    = URI.escape("https://query.yahooapis.com/v1/public/yql?q=#{query}&format=json")
      buffer = open(url).read
      JSON.parse(buffer)
    end

  end

end
