require File.expand_path('../test_helper', __FILE__)

describe "AbnAmro::Internetkassa::Helpers", ActionView::TestCase do
  tests AbnAmro::Internetkassa::Helpers
  
  before do
    @controller = TestController.new
    
    @instance = AbnAmro::Internetkassa.new(
      :order_id => 123,
      :amount => 1000,
      :description => "HappyHardcore vol. 123 - the ballads",
      :TITLE => 'HappyHardcore vol. 123 - the ballads'
    )
    
    # make sure we don't get bitten by sorting
    ordered_data = @instance.data.to_a
    @instance.stubs(:data).returns(ordered_data)
  end
  
  it "should create a form tag with the AbnAmro::Internetkassa.service_url as its action" do
    expected = %{<form action="#{AbnAmro::Internetkassa.service_url}" method="post">}
    internetkassa_form_tag(@instance)[0..expected.length-1].should == expected
  end
  
  it "should create a form with data from a AbnAmro::Internetkassa instance and yield" do
    internetkassa_form_tag(@instance) { concat "<p>What a nice looking payment page!</p>" }
    
    expected = %{<form action="#{AbnAmro::Internetkassa.service_url}" method="post">}
    @instance.data.each do |name, value|
      expected += %{<input name="#{name}" type="hidden" value="#{value}" />}
    end
    expected += "<p>What a nice looking payment page!</p>"
    expected += "</form>"
    
    assert_dom_equal expected, output_buffer
  end
  
  private
  
  def method_missing(method, *args, &block)
    @controller.send(method, *args, &block)
  end
end