require 'spec_helper'

describe BreedersController do
  # describe "searching by breeder" do
  #   it "should find dogs for a breeder by name" do
  #     breeder = FactoryGirl.build(:breeder)
  #     dogs = (1..10).map do |i|
  #       FactoryGirl.build(:pup, :breeder_id => breeder.id)
  #     end
  #     Breeder.should_receive(:find_by_name).with("Teddy Roosevelt").and_return(breeder)
  #     breeder.stub(:pups).and_return(dogs)
  #     get :search_name, {:breeders => {:breeder_name => "Teddy Roosevelt"}}
  #   end

  #   it "should redirect to main page if breeder doesn't exist" do
  #     Breeder.should_receive(:find_by_name).with("Erik Bartlett").and_return(nil)
  #     get :search_name, {:breeders =>{:breeder_name => "Erik Bartlett"}}
  #     response.should redirect_to root_path
  #   end
  # end

  # describe "creating new breeder" do
  #   before :each do
  #     @breeder = FactoryGirl.create(:breeder, :name => "Mcgoo", :location => "90210")
  #     @breeder_build = FactoryGirl.build(:breeder, :name => "Jmac", :location => "94704")
  #     @params = {:name => "Jmac", :city => "Berkeley", :state => "CA"}
  #   end

  #   it "should create new breeder and redirect to create pups page" do
  #     Breeder.should_receive(:find_or_create)
  #         .with(@params[:name], @params[:city], @params[:state])
  #         .and_return([@breeder_build, "Erik"])
  #     post :create, {:new_breeder => @params}
  #     response.should redirect_to new_pup_path(:button_clicked => "Create", :breeder_id => @breeder_build.id)
  #   end
  # end

  describe "sending json of all breeders" do
    before :each do
      @breeders = (1..10).map do |i|
        FactoryGirl.build(:breeder)
      end
    end

    it "should send all breeders in a json array" do
      Breeder.should_receive(:all).and_return(@breeders)
      xhr :get, :index
      response.body.should == @breeders.to_json
    end

    it "should send a limited number of breeders starting with given string" do
      Breeder.should_receive(:find_by_substring).with("Teddy - Berkeley, CA", 0).and_return(@breeders)
      xhr :get, :search_breeder, {:name => "Teddy - Berkeley, CA", :limit => 0}
      response.body.should == @breeders.to_json
    end

    it "should render an html page if request is not xhr" do
      Breeder.should_receive(:all).and_return(@breeders)
      get :index
      response.should render_template 'index'
    end
  end
end
