require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Meme" do

  describe "info" do

    before :each do
      @name = "jtadeulopes"
      query = "SELECT%20*%20FROM%20meme.info%20WHERE%20name%3D'#{@name}'"
      url = "https://query.yahooapis.com/v1/public/yql?q=#{query}&format=json"
      FakeWeb.register_uri(:get, url, :body => load_fixture('meme_info.json'))
      @profile = Meme.new(@name)
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

  describe "search" do

    describe "attibutes" do

      before :each do
        url = "https://query.yahooapis.com/v1/public/yql?q=SELECT%20*%20FROM%20meme.search%20WHERE%20query%3D%22meme%20rocks%22%3B&format=json"
        # FakeWeb.register_uri(:get, url, :body => load_fixture('meme_info.json'))
        @results = Meme.search('meme rocks')
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
        @results.first.content.should == "okay...it&#39;s meme in english...starting meme ^.&lt;) rock!!"
      end

      it "should return repost_count" do
        @results.first.repost_count.should == "0"
      end

      it "should return caption" do
        @results.first.caption.should == ""
      end

    end

    describe "combined search" do

      it "should find by 'cat' and type 'photo'" do
        @results = Meme.search('cat', :type => :photo)
        @results.first.content.should == "http://d.yimg.com/gg/u/94909e01ff2130c7b6c733d255ff11193c9a8df9.jpeg"
      end

      it "should find by user 'jtadeulopes' and type 'photo'" do
        pending
      end

      it "should find by hashtag '#fail' and type 'photo'" do
        pending
      end

      it "should find by 'meme rocks' and sort by 'reposts'" do
        pending
      end

    end
    
  end

  def load_fixture(name)
    File.join(File.expand_path(File.dirname(__FILE__)), '/fixtures', name)
  end

end
