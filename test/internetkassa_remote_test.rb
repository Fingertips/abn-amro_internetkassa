require File.expand_path('../test_helper', __FILE__)

require 'rest'
require 'hpricot'

describe "AbnAmro::Internetkassa, when remote testing" do
  before do
    @instance = AbnAmro::Internetkassa.new(
      :order_id => 123,
      :amount => 1000,
      :description => "HappyHardcore vol. 123 - the ballads",
      :TITLE => 'HappyHardcore vol. 123 - the ballads'
    )
  end
  
  it "should have the right data to make a successful POST request" do
    response = post(AbnAmro::Internetkassa.service_url, @instance.data)
    response.should.be.success
    
    parse_response(response).should == {
      :beneficiary => 'Fingertips BV',
      :order_id =>    '123',
      :amount =>      '10.00 EUR',
      :title =>       'HappyHardcore vol. 123 - the ballads'
    }
  end
  
  private
  
  def post(uri, values)
    body = values.map { |k,v| "#{k}=#{v.to_s.gsub(' ', '%20')}" }.join('&')
    REST.post(uri, body)
  end
  
  def parse_response(response)
    results = {}
    
    doc = Hpricot(response.body)
    (doc / '#ncol_ref' / 'tr').each do |row|
      cols = (row / 'td')
      
      key = case cols.first.inner_text
      when /Ordernummer/
        :order_id
      when /Totaalbedrag/
        :amount
      when /Begunstigde/
        :beneficiary
      end
      
      results[key] = cols.last.inner_text.strip
    end
    
    results[:title] = (doc / 'title').inner_text.strip
    results
  end
end