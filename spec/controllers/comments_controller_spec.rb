require 'spec_helper'

describe CommentsController do
  render_views

  describe "access control" do

    it "should deny access to 'create'" do
      post :create
      response.should redirect_to(signin_path)
    end

    it "should deny access to 'destroy'" do
      delete :destroy, :id => 1
      response.should redirect_to(signin_path)
    end
  end
  
  describe "POST 'create'" do

    before(:each) do
      @user = test_sign_in(Factory(:user))
    end

    describe "failure" do

      before(:each) do
        @attr = { :content => "" }
      end

      it "should not create a comment" do
        lambda do
          post :create, :comment => @attr
        end.should_not change(Comment, :count)
      end

      it "should render the home page" do
        post :create, :comment => @attr
        response.should render_template('pages/home')
      end
    end

    describe "success" do

      before(:each) do
        @attr = { :content => "Lorem ipsum" }
      end

      it "should create a comment" do
        lambda do
          post :create, :comment => @attr
        end.should change(Comment, :count).by(1)
      end

      it "should redirect to the home page" do
        post :create, :comment => @attr
        response.should redirect_to(root_path)
      end

      it "should have a flash message" do
        post :create, :comment => @attr
        flash[:success].should =~ /comment created/i
      end
    end
  end
end