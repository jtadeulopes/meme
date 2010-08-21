require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Meme::Info" do

  before :each do
    query = "SELECT * FROM meme.info WHERE name='jtadeulopes'"
    fake_web(query, 'meme_info.json')
    @profile = Meme::Info.find('jtadeulopes')
  end

  Meme::Info::VARS.each do |attr|
    it { @profile.should respond_to(attr) }
  end

  describe "::find" do

    it "if user not found, should return nil" do
      query = "SELECT * FROM meme.info WHERE name='memeusernotfound'"
      fake_web(query, 'meme_info_not_found.json')
      Meme::Info.find('memeusernotfound').should be_nil
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

  end

  describe "::find_by_guid" do

    before :each do
      query = "SELECT * FROM meme.info WHERE owner_guid='QKSXELRVSAWRI77FVKODDYTKB4'"
      fake_web(query, 'meme_info_guid.json')
      @profile_guid = Meme::Info.find_by_guid('QKSXELRVSAWRI77FVKODDYTKB4')
    end

    it "should return name" do
      @profile_guid.name.should == "tempestadesilenciosa"
    end

    it "should return guid" do
      @profile_guid.guid.should == "QKSXELRVSAWRI77FVKODDYTKB4"
    end

  end

  describe "#followers" do

    it "should return followers" do
      query = "SELECT * FROM meme.followers(10) WHERE owner_guid='EMREXCV4R5OTM3CZW3HBD5QAGY'"
      fake_web(query, 'meme_followers.json')
      @profile.followers.count.should == 10
    end

    it "should return five followers" do
      query = "SELECT * FROM meme.followers(5) WHERE owner_guid='EMREXCV4R5OTM3CZW3HBD5QAGY'"
      fake_web(query, 'meme_followers_count.json')
      @profile.followers(5).count.should == 5
    end

    it "should return all followers" do
      query = "SELECT * FROM meme.followers(0) WHERE owner_guid='EMREXCV4R5OTM3CZW3HBD5QAGY'"
      fake_web(query, 'meme_followers_all.json')
      @profile.followers(:all).count.should == 36
    end

  end

  describe "#following" do

    it "should return following" do
      query = "SELECT * FROM meme.following(10) WHERE owner_guid='EMREXCV4R5OTM3CZW3HBD5QAGY'"
      fake_web(query, 'meme_following.json')
      @profile.following.count.should == 10
    end

    it "should return seven following" do
      query = "SELECT * FROM meme.following(7) WHERE owner_guid='EMREXCV4R5OTM3CZW3HBD5QAGY'"
      fake_web(query, 'meme_following_count.json')
      @profile.following(7).count.should == 7
    end

    it "should return all following" do
      query = "SELECT * FROM meme.following(0) WHERE owner_guid='EMREXCV4R5OTM3CZW3HBD5QAGY'"
      fake_web(query, 'meme_following_all.json')
      @profile.following(:all).count.should == 39
    end

  end

  describe "#posts" do

    before :each do
      @query = "SELECT * FROM meme.posts(0) WHERE owner_guid='EMREXCV4R5OTM3CZW3HBD5QAGY';"
      fake_web(@query, 'meme_user_posts.json')
    end

    it { @profile.should respond_to(:posts) }

    Meme::Post::VARS.each do |attr|
      it { @profile.posts.first.should respond_to(attr) }
    end
    
    it "should return user posts" do
      query = "SELECT * FROM meme.posts(2) WHERE owner_guid='EMREXCV4R5OTM3CZW3HBD5QAGY';"
      fake_web(query, 'meme_user_posts_count.json')
      posts = @profile.posts(2)
      posts.count.should == 2
    end

    it "when not specified quantity, should return all posts" do
      @profile.posts.count.should == 51
    end

  end

end
