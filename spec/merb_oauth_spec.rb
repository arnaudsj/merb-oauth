require File.dirname(__FILE__) + '/spec_helper2'
require 'oauth'

describe "MerbOauth" do
  
  class Nothing < Merb::Controller
    
    def index
      "hello!"
    end
    
  end
  
  
  
  
  
  class Oauth < Merb::Controller

    before :require_signed_request, :only => [:request_token]
    before :require_request_token, :only => [:access_token]
    before :require_access_token, :only => [:contact_list]

    # GET /contact_list
    def contact_list
      # You now have access to the authorized user through self.current_token
      render "contact list for #{current_token.user.email}" 
    end

  
    # POST /oauth/request_token
    def request_token
      @token = RequestToken.create :client_application => current_application

      if @token.valid?
        render @token.to_query, :layout => false
      else
        render "", :status => 401
      end
    
    end 
  
    # POST /oauth/access_token
    def access_token
      @token = current_token.exchange!
    
      if @token
        render @token.to_query, :layout => false
      else
        render "", :status => 401
      end
    end
  
    # POST /oauth/authorize
    def authorize
      @token = RequestToken.first(:token => params[:oauth_token])
    
      @token.authorize!(params[:user])
          
      redirect (params[:oauth_callback] || @token.client_application.callback_url) + "?oauth_token=#{@token.token}"
    end
  
    # POST /oauth/revoke
    def revoke
      if @token = Token.first(:token => params[:token])
        @token.invalidate!
        render "", :status => 200
      else
        render "", :status => 404
      end
    end
  
    protected
  
    # Called from merb_oauth OAuthMixin
    override! :find_application_by_key 
    def find_application_by_key(key)
      ClientApplication.first(:consumer_key => key)
    end
  
    # Called from merb_oauth OAuthMixin
    override! :find_token
    def find_token(token)
      Token.first(:token => token)
    end
  
  end
  
  
  describe "making a simple request" do
    it "should display the form to login" do
      response = request('/nothing/index')
      response.should be_successful
    end
  end
end
