require File.expand_path('../test_helper', __FILE__)

xdescribe "AbnAmro::Internetkassa, when remote testing" do
  it "should create the collect the right values to post" do
    AbnAmro::Internetkassa.new(
      :id => 123,
      :amount => 1000,
      :description => "HappyHardcore vol. 123 - the ballads"
    )
  end
  
  private
  
  def post(url, options)
    
  end
end