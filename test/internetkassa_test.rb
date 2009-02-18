require File.expand_path('../test_helper', __FILE__)

describe "AbnAmro::Internetkassa, class methods" do
  it "should return whether or not it's in test mode" do
    assert AbnAmro::Internetkassa.test?
  end
  
  it "should return the PSPID with #pspid or its aliased handsome cousin #merchant_id" do
    # set in test_helper.rb
    AbnAmro::Internetkassa.pspid.should == 'fingertips'
    AbnAmro::Internetkassa.merchant_id.should == 'fingertips'
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
    @valid_attributes = {
      :order_id => 123,
      :amount => 1000,
      :description => "HappyHardcore vol. 123 - the ballads"
    }
    @instance = AbnAmro::Internetkassa.new(@valid_attributes)
  end
  
  it "should have assigned the constructor arguments" do
    @instance.order_id.should == 123
    @instance.amount.should == 1000
    @instance.description.should == "HappyHardcore vol. 123 - the ballads"
  end
  
  it "should have merged default values" do
    @instance.currency.should == 'EUR'
    @instance.language.should == 'nl_NL'
  end
  
  it "should have access to the pspid/merchant_id" do
    @instance.send(:merchant_id).should == AbnAmro::Internetkassa.merchant_id
  end
  
  it "should verify that the mandatory values are specified or raise an ArgumentError" do
    %w{ merchant_id order_id amount currency language }.each do |key|
      instance = AbnAmro::Internetkassa.new(@valid_attributes)
      instance.stubs(key).returns(nil)
      lambda { instance.send(:verify_values!) }.should.raise ArgumentError
    end
  end
  
  it "should return the key-value pairs that should be POSTed, according to the Internetkassa specs" do
    @instance.data.should == {
      :PSPID => AbnAmro::Internetkassa.merchant_id,
      :orderID => @instance.order_id,
      :amount => @instance.amount,
      :currency => @instance.currency,
      :language => @instance.language,
      :COM => @instance.description
    }
  end
  
  it "should check if all mandatory values are specified before returning the `data'" do
    @instance.expects(:verify_values!)
    @instance.data
  end
  
  it "should merge any optional arguments with the data" do
    @valid_attributes[:TITLE] = 'My Transaction'
    AbnAmro::Internetkassa.new(@valid_attributes).data.should == {
      :PSPID => AbnAmro::Internetkassa.merchant_id,
      :orderID => @instance.order_id,
      :amount => @instance.amount,
      :currency => @instance.currency,
      :language => @instance.language,
      :COM => @instance.description,
      :TITLE => 'My Transaction'
    }
  end
end