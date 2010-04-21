require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Meme::Post" do

  describe "#find" do

    before :each do
      query = "SELECT * FROM meme.search WHERE query='meme rocks'"
      fake_web(query, 'meme_search.json')
      @results = Meme::Post.find('meme rocks')
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

    it "if posts not found, should return nil" do
      query = "SELECT * FROM meme.search WHERE query='brhackday' and type='audio'"
      fake_web(query, 'meme_search_type_audio.json')
      Meme::Post.find('brhackday', :type => :audio).should be_nil
    end

    context "using the option :type" do

      it "type photo" do
        query = "SELECT * FROM meme.search WHERE query='meme rocks' and type='photo'"
        fake_web(query, 'meme_search_type_photo.json')
        @results = Meme::Post.find('meme rocks', :type => :photo)
        @results.count.should == 3
        @results.first.type.should == "photo"
      end

      it "type video" do
        query = "SELECT * FROM meme.search WHERE query='keyboard cat' and type='video'"
        fake_web(query, 'meme_search_type_video.json')
        @results = Meme::Post.find('keyboard cat', :type => :video)
        @results.count.should == 2
        @results.first.type.should == "video"
      end

    end

  end

end
