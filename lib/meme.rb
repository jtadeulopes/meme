class Meme

  def initialize(owner_guid)
    query = "SELECT%20*%20FROM%20meme.info%20WHERE%20owner_guid%3D'#{owner_guid}'"
    url_info = "https://query.yahooapis.com/v1/public/yql?q=#{query}&format=json"
    buffer = open(url_info, "UserAgent" => "Ruby-Wget").read
    @owner = JSON.parse(buffer)
  end

  def name
    @owner["query"]["results"]["meme"]["name"]
  end

  def guid
    @owner["query"]["results"]["meme"]["guid"]
  end

  def title 
    @owner["query"]["results"]["meme"]["title"]
  end

  def description
    @owner["query"]["results"]["meme"]["description"]
  end

  def url 
    @owner["query"]["results"]["meme"]["url"]
  end

  def avatar_url
    @owner["query"]["results"]["meme"]["avatar_url"]
  end

  def language
    @owner["query"]["results"]["meme"]["language"]
  end

  def followers
    @owner["query"]["results"]["meme"]["followers"]
  end
  
end
