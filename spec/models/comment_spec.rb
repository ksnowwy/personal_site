require 'spec_helper'

describe Comment do

  before(:each) do
    @user = Factory(:user)
    @attr = { :content => "value for content" }
  end

  it "should create a new instance given valid attributes" do
    @user.comments.create!(@attr)
  end

  describe "user associations" do

    before(:each) do
      @comment = @user.comments.create(@attr)
    end

    it "should have a user attribute" do
      @comment.should respond_to(:user)
    end

    it "should have the right associated user" do
      @comment.user_id.should == @user.id
      @comment.user.should == @user
    end
  end
  
  describe "validations" do

    it "should require a user id" do
      Comment.new(@attr).should_not be_valid
    end

    it "should require nonblank content" do
      @user.comments.build(:content => "  ").should_not be_valid
    end
  end
end