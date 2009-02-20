require File.expand_path('../test_helper', __FILE__)

describe "AbnAmro::Internetkassa::Response, in general" do
  before do
    @response = AbnAmro::Internetkassa::Response.new(fixture(:succeeded))
  end
  
  it "should return the raw params" do
    @response.params.should == fixture(:succeeded)
  end
  
  it "should return whether or not the transaction was authorized" do
    @response.stubs(:status_code).returns('5')
    @response.should.be.authorized
    
    @response.stubs(:status_code).returns('9')
    @response.should.not.be.authorized
  end
  
  it "should return whether or not the transaction was captured" do
    @response.stubs(:status_code).returns('9')
    @response.should.be.captured
    
    @response.stubs(:status_code).returns('5')
    @response.should.not.be.captured
  end
  
  it "should return the essential attributes" do
    @response.order_id.should       == '1235052040'
    @response.payment_id.should     == '3051611'
    @response.payment_method.should == 'iDEAL'
    @response.acceptance.should     == '0000000000'
    @response.status_code.should    == '9'
    @response.signature.should      == '7537DD222E35EE9F9842921BD90C2CBFCFA59466'
    @response.currency.should       == 'EUR'
  end
  
  it "should return the optional attributes" do
    @response.customer_name.should        == 'Buyer name'
    @response.card_number.should          == '11-XXXX-11'
    @response.card_brand.should           == 'iDEAL'
    @response.card_expiration_date.should == ''
  end
  
  it "should return the amount in cents" do
    @response.instance_variable_set(:@params, 'amount' => '10')
    @response.amount.should == 1000
  end
  
  it "should return the amount with decimals in cents" do
    @response.instance_variable_set(:@params, 'amount' => '10.31')
    @response.amount.should == 1031
  end
  
  it "should return the transaction date as a Date instance" do
    @response.transaction_date.should == Date.parse('02/19/2009')
  end
  
  it "should create a SHA1 signature for the message" do
    message =  @response.order_id
    message += @response.currency
    message += @response.params['amount']
    message += @response.payment_method
    message += @response.acceptance
    message += @response.status_code
    message += @response.card_number
    message += @response.payment_id
    message += @response.params['NCERROR']
    message += @response.card_brand
    
    message += AbnAmro::Internetkassa.passphrase
    
    @response.send(:calculated_signature).should == Digest::SHA1.hexdigest(message).upcase
  end
  
  it "should return that the signature matches the calculated_signature" do
    @response.should.be.valid
  end
  
  it "should return that the signature does NOT match the calculated_signature" do
    @response.stubs(:signature).returns('NOT A VALID SHA1 SIGNATURE')
    @response.should.not.be.valid
  end
  
  it "should raise a SignatureInvalidError if initializing a response and the signature does not match the calculated_signature" do
    params = fixture(:succeeded).dup
    params['SHASIGN'] = 'NOT A VALID SHA1 SIGNATURE'
    
    lambda {
      AbnAmro::Internetkassa::Response.new(params)
    }.should.raise AbnAmro::Internetkassa::Response::SignatureInvalidError
  end
  
  it "should return the message for the status code" do
    @response.status_message.should == 'Payment requested'
  end
end

describe "AbnAmro::Internetkassa::Response, with a successful payment" do
  before do
    @response = AbnAmro::Internetkassa::Response.new(fixture(:succeeded))
  end
  
  it "should be successful" do
    @response.should.be.success
  end
  
  it "should not be retryable" do
    @response.should.not.retry
  end
  
  it "should return `nil' as the error code" do
    @response.error_code.should.be nil
  end
  
  it "should return `nil' as the error message" do
    @response.error_message.should.be nil
  end
end

describe "AbnAmro::Internetkassa::Response, with a failed payment" do
  before do
    @response = AbnAmro::Internetkassa::Response.new(fixture(:failed))
  end
  
  it "should not be successful" do
    @response.should.not.be.success
  end
  
  it "should not be retryable" do
    @response.should.not.retry
  end
  
  it "should return the error code" do
    @response.error_code.should == "30001001"
  end
  
  it "should return the error message" do
    @response.error_message.should == "Payment refused by the acquirer"
  end
end

describe "AbnAmro::Internetkassa::Response, with a cancelled payment" do
  before do
    @response = AbnAmro::Internetkassa::Response.new(fixture(:cancelled))
  end
  
  it "should not be successful" do
    @response.should.not.be.success
  end
  
  it "should not be retryable" do
    @response.should.not.retry
  end
  
  it "should return the error code" do
    @response.error_code.should == "30171001"
  end
  
  it "should return the error message" do
    @response.error_message.should == "Payment method cancelled by the buyer"
  end
end

describe "AbnAmro::Internetkassa::Response, when an exception occurred" do
  before do
    @response = AbnAmro::Internetkassa::Response.new(fixture(:exception))
  end
  
  it "should not be successful" do
    @response.should.not.be.success
  end
  
  it "should not be retryable" do
    @response.should.not.retry
  end
  
  it "should return the error code" do
    @response.error_code.should == "20002001"
  end
  
  it "should return the error message" do
    @response.error_message.should == "Origin for the response of the bank can not be checked"
  end
end