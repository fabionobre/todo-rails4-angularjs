require 'spec_helper'

describe CallbacksController, "handle facebook and google authentication callback" do
  
  OmniAuth.config.test_mode = true

  context "when a user try to connect with facebook" do

    before do        
      OmniAuth.config.add_mock(:facebook, {:uid => '12345', :info => {:email => 'someone@somewhere.com'}})
      request.env["devise.mapping"] = Devise.mappings[:user] 
      request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:facebook] 
    end

    it "should redirect to root page" do
      get :facebook
      response.should redirect_to root_path
    end

    it "should raise an error" do
      OmniAuth.config.mock_auth[:facebook] = nil
      request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:facebook] 

      expect { get :facebook }.to raise_error
    end

  end

  context "when a user try to connect with google" do

    before do        
      OmniAuth.config.add_mock(:google_oauth2, {:uid => '12345', :info => {:email => 'someone@somewhere.com'}})
      request.env["devise.mapping"] = Devise.mappings[:user] 
      request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:google_oauth2] 
    end

    it "should redirect to root page" do
      get :google_oauth2
      response.should redirect_to root_path
    end

    it "should raise an error" do
      OmniAuth.config.mock_auth[:google] = nil
      request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:google] 

      expect { get :google_oauth2 }.to raise_error
    end
  end
end