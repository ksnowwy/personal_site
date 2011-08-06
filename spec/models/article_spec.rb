require 'spec_helper'

describe Article do

  before(:each) do
    @user = Factory(:user)
    @attr = { :content => "value for content" }
  end

  it "should create a new instance given valid attributes" do
    @user.articles.create!(@attr)
  end

  describe "user associations" do

    before(:each) do
      @article = @user.articles.create(@attr)
    end

    it "should have a user attribute" do
      @article.should respond_to(:user)
    end

    it "should have the right associated user" do
      @article.user_id.should == @user.id
      @article.user.should == @user
    end
  end
  
  describe "validations" do

    it "should require a user id" do
      Article.new(@attr).should_not be_valid
    end

    it "should require nonblank content" do
      @user.articles.build(:content => "  ").should_not be_valid
    end
  end
  
  describe "comment associations" do

    before(:each) do
      @article = Article.create(@attr)
      @ac1 = Factory(:comment, :article => @article, :created_at => 1.day.ago)
      @ac2 = Factory(:comment, :article => @article, :created_at => 1.hour.ago)
    end

    it "should have a comments attribute" do
      @article.should respond_to(:comments)
    end

    it "should have the right comments in the right order" do
      @article.comments.should == [@ac2, @ac1]
    end
    
    it "should destroy associated comments" do
      @article.destroy
      [@ac1, @ac2].each do |comment|
        Comment.find_by_id(comment.id).should be_nil
      end
    end
  end
end