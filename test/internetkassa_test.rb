require File.expand_path('../test_helper', __FILE__)

describe "AbnAmro::Internetkassa, class methods" do
  it "should return whether or not it's in test mode" do
    assert AbnAmro::Internetkassa.test?
  end
  
  it "should have the correct service_urls" do
    AbnAmro::Internetkassa::TEST_URL.should ==
      "https://internetkassa.abnamro.nl/ncol/test/orderstandard.asp"
    
    AbnAmro::Internetkassa::PRODUCTION_URL.should ==
      "https://internetkassa.abnamro.nl/ncol/prod/orderstandard.asp"
  end
  
  it "should return the service_url for the current environment" do
    begin
      AbnAmro::Internetkassa.test = true
      AbnAmro::Internetkassa.service_url.should ==
        AbnAmro::Internetkassa::TEST_URL
      
      AbnAmro::Internetkassa.test = false
      AbnAmro::Internetkassa.service_url.should ==
        AbnAmro::Internetkassa::PRODUCTION_URL
    ensure
      AbnAmro::Internetkassa.test = true
    end
  end
end

describe "AbnAmro::Internetkassa, an instance" do
  before do
    @instance = AbnAmro::Internetkassa.new(
      :order_id => 123,
      :amount => 1000,
      :description => "HappyHardcore vol. 123 - the ballads"
    )
  end
  
  it "should have assigned the constructor arguments" do
    @instance.order_id.should == 123
    @instance.amount.should == 1000
    @instance.description.should == "HappyHardcore vol. 123 - the ballads"
  end
end