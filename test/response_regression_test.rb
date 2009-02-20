require File.expand_path('../test_helper', __FILE__)

describe "AbnAmro::Internetkassa::Response, regression tests" do
  before do
    @response = AbnAmro::Internetkassa::Response.new({})
  end
  
  it "should be retryable" do
    retry_codes = AbnAmro::Internetkassa::Response::Codes::ERROR_CODES.select { |_,h| h[:retry] }
    retry_codes.should.not.be.empty
    
    retry_all = retry_codes.all? do |code, _|
      @response.stubs(:error_code).returns(code)
      @response.retry?
    end
    
    retry_all.should.be true
  end
  
  it "should not be retryable" do
    dont_retry_codes = AbnAmro::Internetkassa::Response::Codes::ERROR_CODES.select { |_,h| !h[:retry] }
    dont_retry_codes.should.not.be.empty
    
    dont_retry_any = dont_retry_codes.all? do |code, _|
      @response.stubs(:error_code).returns(code)
      @response.retry? == false
    end
    
    dont_retry_any.should.be true
  end
end