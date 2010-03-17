require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Meme" do

  describe "info" do

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

  end

  def load_fixture(name)
    File.join(File.expand_path(File.dirname(__FILE__)), '/fixtures', name)
  end

end
