require 'spec_helper'

describe GenresController do

  describe "GET 'index'" do
    it "should be successful" do
      get :index
      response.should be_success
    end
  end

  describe "GET 'show'" do
    it "should be successful" do
      get :show, :id => 1
      response.should be_success
    end
  end

end
