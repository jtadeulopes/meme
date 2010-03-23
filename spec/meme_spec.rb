require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Meme" do

  describe "info" do

    describe "#user not found" do
      it "should return nil" do
        url  = URI.escape("https://query.yahooapis.com/v1/public/yql?q=SELECT * FROM meme.info WHERE name='memeusernotfound'&format=json")
        FakeWeb.register_uri(:get, url, :body => load_fixture('meme_info_not_found.json'))
        Meme::Info.find('memeusernotfound').should be_nil
      end
    end

    before :each do
      name = "jtadeulopes"
      url  = URI.escape("https://query.yahooapis.com/v1/public/yql?q=SELECT * FROM meme.info WHERE name='#{name}'&format=json")
      FakeWeb.register_uri(:get, url, :body => load_fixture('meme_info.json'))
      @profile = Meme::Info.find(name)
    end
    
    it "should return name" do
      @profile.name.should == "jtadeulopes"
    end

    it "should return guid" do
      @profile.guid.should == "EMREXCV4R5OTM3CZW3HBD5QAGY"
    end

    it "should return page title" do
      @profile.title.should == "Jésus Lopes"
    end
    
    it "should return description" do
      @profile.description.should == "software developer"
    end

    it "should return url" do
      @profile.url.should == "http://meme.yahoo.com/jtadeulopes/"
    end

    it "should return avatar" do
      @profile.avatar_url.should == "http://d.yimg.com/gg/jtadeulopes/avatars/44251e70378d4d225f8cda09a6c3aec87301833a.jpeg"
    end

    it "should return language" do
      @profile.language.should == "pt"
    end

    it "should return followers" do
      @profile.followers.should == "34"
    end

  end

  describe "#search" do

    before :each do
      query = 'meme rocks'
      url = URI.escape("https://query.yahooapis.com/v1/public/yql?q=SELECT * FROM meme.search WHERE query='#{query}'&format=json")
      FakeWeb.register_uri(:get, url, :body => load_fixture('meme_search.json'))
      @results = Meme::Post.find(query)
    end

    it "should return pubid" do
      @results.first.pubid.should == "yC8nqOd"
    end

    it "should return guid" do
      @results.first.guid.should == "7Z7XFAPD5FLXFKJVT4NG6XTTA4"
    end

    it "should return url" do
      @results.first.url.should == "http://meme.yahoo.com/celizelove/p/yC8nqOd/"
    end

    it "should return timestamp" do
      @results.first.timestamp.should == "1268410909000"
    end

    it "should return category" do
      @results.first.category.should == "text"
    end

    it "should return type" do
      @results.first.type.should == "text"
    end

    it "should return content" do
      @results[4].content.should == "http://d.yimg.com/gg/u/2441eceb4b334c6fc29c9bd306fe1957693d605e.jpeg"
    end

    it "should return repost_count" do
      @results.first.repost_count.should == "0"
    end

    it "should return caption" do
      @results[1].caption.should == "This is good. But a lot of things happening means a high chance that I, the man who lives and breathes Panic and has a giant status board in my head, might not properly explain everything to everyone. Steve and I realized it was high time we made this Cabel Status Board public… using technology!"
    end

  end

  describe "#search by type" do

    describe "#posts not found" do
      it "should return nil" do
        query = 'brhackday'
        fake_web(query, 'audio')
        Meme::Post.find(query, :type => :audio).should be_nil
      end
    end

    it "should search by type photo" do
      query = 'meme rocks'
      fake_web(query, 'photo')
      @results = Meme::Post.find(query, :type => :photo)
      @results.count.should == 3
      @results.first.type.should == "photo"
    end
    it "should search by type video" do
      query = 'keyboard cat'
      fake_web(query, 'video')
      @results = Meme::Post.find(query, :type => :video)
      @results.count.should == 2
      @results.first.type.should == "video"
    end

    def fake_web(query, type)
      select = "SELECT * FROM meme.search WHERE query='#{query}' and type='#{type}'"
      url  = URI.escape("https://query.yahooapis.com/v1/public/yql?q=#{select}&format=json")
      FakeWeb.register_uri(:get, url, :body => load_fixture("meme_search_type_#{type}.json"))
    end

  end

  def load_fixture(name)
    File.join(File.expand_path(File.dirname(__FILE__)), '/fixtures', name)
  end

end
