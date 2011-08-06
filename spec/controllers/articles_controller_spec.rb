require 'spec_helper'

describe ArticlesController do
  render_views

  describe "GET 'show'" do
    
    before(:each) do
      @article = Factory(:article)
    end

    it "should be successful" do
      get :show, :id => @article
      response.should be_success
    end

    it "should find the right article" do
      get :show, :id => @article
      assigns(:article).should == @article
    end
    
    it "should have the right title" do
      get :show, :id => @article
      response.should have_selector("title", :content => @article.heading)
    end

    it "should include the article's heading" do
      get :show, :id => @article
      response.should have_selector("h1", :content => @article.heading)
    end
    
    it "should show the article's comments" do
      ac1 = Factory(:comment, :article => @article, :content => "Foo bar")
      ac2 = Factory(:comment, :article => @article, :content => "Baz quux")
      get :show, :id => @article
      response.should have_selector("span.content", :content => ac1.content)
      response.should have_selector("span.content", :content => ac2.content)
    end
  end

  describe "GET 'new'" do
    
    before(:each) do
      @user = Factory(:user)
    end

    describe "as a non-signed-in user" do
      it "should deny access" do
        get 'new'
        response.should redirect_to(signin_path)
      end
    end

    describe "as a non-admin user" do
      it "should protect the page" do
        test_sign_in(@user)
        get 'new'
        response.should redirect_to(root_path)
      end
    end
    
    describe "as an admin user" do

      before(:each) do
        admin = Factory(:user, :email => "admin@example.com", :admin => true)
        test_sign_in(admin)
      end
    
      it "should be successful" do
        get 'new'
        response.should be_success
      end
  
      it "should have the right title" do
        get 'new'
        response.should have_selector("title", :content => "New article")
      end
    end
  end
  
  describe "POST 'create'" do
    
    before(:each) do
      @user = Factory(:user)
    end

    describe "as a non-signed-in user" do
      it "should not create an article" do
        lambda do
          post :create, :article => @attr
        end.should_not change(Article, :count)
      end
    end

    describe "as a non-admin user" do
      it "should not create an article" do
        test_sign_in(@user)
        lambda do
          post :create, :article => @attr
        end.should_not change(Article, :count)
      end
    end
    
    describe "as an admin user" do

      before(:each) do
        admin = Factory(:user, :email => "admin@example.com", :admin => true)
        test_sign_in(admin)
      end

      describe "failure" do
  
        before(:each) do
          @attr = { :content => "", :heading => "" }
        end
  
        it "should not create an article" do
          lambda do
            post :create, :article => @attr
          end.should_not change(Article, :count)
        end
  
        it "should have the right title" do
          post :create, :article => @attr
          response.should have_selector("title", :content => "New article")
        end
  
        it "should render the 'new' page" do
          post :create, :article => @attr
          response.should render_template('new')
        end
      end
      
      describe "success" do
  
        before(:each) do
          @attr = { :content => "Article new article lorem ipsum bla bla", :heading => "New test" }
        end
  
        it "should create an article" do
          lambda do
            post :create, :article => @attr
          end.should change(Article, :count).by(1)
        end
  
        it "should redirect to the index page" do
          post :create, :user => @attr
          response.should redirect_to(root_path)
        end
      end
    end
  end
  
  describe "GET 'edit'" do
    
    before(:each) do
      @user = Factory(:user)
    end

    describe "as a non-signed-in user" do
      it "should not edit article" do
        get :edit
        response.should redirect_to(signin_path)
      end
    end

    describe "as a non-admin user" do
      it "should not edit article" do
        test_sign_in(@user)
        get :edit
        response.should redirect_to(root_path)
      end
    end

    describe "as an admin user" do

      before(:each) do
        admin = Factory(:user, :email => "admin@example.com", :admin => true)
        test_sign_in(admin)
      end

      it "should be successful" do
        get :edit, :id => @article
        response.should be_success
      end
  
      it "should have the right title" do
        get :edit, :id => @article
        response.should have_selector("title", :content => "Edit article")
      end
    end
  end
  
  describe "PUT 'update'" do
    
    before(:each) do
      @user = Factory(:user)
    end

    describe "as a non-signed-in user" do
      it "should not be able to update" do
        put :update
        response.should redirect_to(signin_path)
      end
    end

    describe "as a non-admin user" do
      it "should not be able to update" do
        test_sign_in(@user)
        put :update
        response.should redirect_to(root_path)
      end
    end

    describe "as an admin user" do

      before(:each) do
        admin = Factory(:user, :email => "admin@example.com", :admin => true)
        test_sign_in(admin)
      end

      describe "failure" do
  
        before(:each) do
          @attr = { :content => "", :heading => "" }
        end
  
        it "should render the 'edit' page" do
          put :update, :id => @article, :article => @attr
          response.should render_template('edit')
        end
  
        it "should have the right title" do
          put :update, :id => @article, :article => @attr
          response.should have_selector("title", :content => "Edit article")
        end
      end
  
      describe "success" do
  
        before(:each) do
          @attr = { :content => "Long article about stuff", :heading => "A heading" }
        end
  
        it "should change the article's attributes" do
          put :update, :id => @article, :article => @attr
          @article.reload
          @article.content.should  == @attr[:content]
          @user.heading.should == @attr[:heading]
        end
  
        it "should redirect to the article show page" do
          put :update, :id => @article, :article => @attr
          response.should redirect_to(article_path(@article))
        end
  
        it "should have a flash message" do
          put :update, :id => @article, :article => @attr
          flash[:success].should =~ /updated/
        end
      end
    end
  end
  
  describe "DELETE 'destroy'" do

    before(:each) do
      @user = Factory(:user)
    end

    describe "as a non-signed-in user" do
      it "should deny access" do
        delete :destroy
        response.should redirect_to(signin_path)
      end
    end

    describe "as a non-admin user" do
      it "should protect the page" do
        test_sign_in(@user)
        delete :destroy
        response.should redirect_to(root_path)
      end
    end

    describe "as an admin user" do

      before(:each) do
        admin = Factory(:user, :email => "admin@example.com", :admin => true)
        test_sign_in(admin)
      end

      it "should destroy the article" do
        lambda do
          delete :destroy, :id => @article
        end.should change(Article, :count).by(-1)
      end

      it "should redirect to the index page" do
        delete :destroy, :id => @article
        response.should redirect_to(root_path)
      end
    end
  end
end