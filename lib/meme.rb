class Meme

  class Info

    def initialize(name)
      query     = "SELECT%20*%20FROM%20meme.info%20WHERE%20name%3D'#{name}'"
      url_info  = "https://query.yahooapis.com/v1/public/yql?q=#{query}&format=json"
      buffer    = open(url_info, "UserAgent" => "Ruby-Wget").read
      @owner    = JSON.parse(buffer)
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
