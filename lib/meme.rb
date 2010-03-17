class Meme

  class Info

    def initialize(name)
      url     = URI.escape("https://query.yahooapis.com/v1/public/yql?q=SELECT * FROM meme.info WHERE name='#{name}'&format=json")
      buffer  = open(url).read
      @owner  = JSON.parse(buffer)
      self.class.define = @owner
    end

    # Find user by name
    #
    def self.find(name)
      Info.new(name)
    end

    private

    def self.define=(owner)
      owner['query']['results']['meme'].each do |key, value|
        define_method(key) { value }
      end
    end

  end

end
