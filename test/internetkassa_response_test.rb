require File.expand_path('../test_helper', __FILE__)

describe "AbnAmro::Internetkassa::Response, with a successful payment" do
  before do
    @response = AbnAmro::Internetkassa::Response.new(fixture(:succeeded))
  end
  
  it "should be successful" do
    @response.should.be.success
  end
end

describe "AbnAmro::Internetkassa::Response, with a failed payment" do
  before do
    @response = AbnAmro::Internetkassa::Response.new(fixture(:failed))
  end
  
  it "should not be successful" do
    @response.should.not.be.success
  end
end

describe "AbnAmro::Internetkassa::Response, with a cancelled payment" do
  before do
    @response = AbnAmro::Internetkassa::Response.new(fixture(:cancelled))
  end
  
  it "should not be successful" do
    @response.should.not.be.success
  end
end

describe "AbnAmro::Internetkassa::Response, when an exception occurred" do
  before do
    @response = AbnAmro::Internetkassa::Response.new(fixture(:exception))
  end
  
  it "should not be successful" do
    @response.should.not.be.success
  end
end