require File.expand_path('../test_helper', __FILE__)

describe "AbnAmro::Internetkassa::Response, with a successful payment" do
  before do
    @response = AbnAmro::Internetkassa::Response.new(
    {"CN"=>"Buyer name", "BRAND"=>"iDEAL", "orderID"=>"1235052040", "PAYID"=>"3051611", "action"=>"index", "ACCEPTANCE"=>"0000000000", "controller"=>"payments", "amount"=>"10", "CARDNO"=>"11-XXXX-11", "PM"=>"iDEAL", "STATUS"=>"9", "IP"=>"83.68.2.74", "TRXDATE"=>"02/19/09", "NCERROR"=>"0", "ED"=>"", "SHASIGN"=>"7537DD222E35EE9F9842921BD90C2CBFCFA59466", "currency"=>"EUR"}
    )
  end
end

describe "AbnAmro::Internetkassa::Response, with a failed payment" do
  before do
    @response = AbnAmro::Internetkassa::Response.new(
    {"CN"=>"", "BRAND"=>"iDEAL", "orderID"=>"1235052641", "PAYID"=>"3051687", "action"=>"index", "ACCEPTANCE"=>"", "controller"=>"payments", "amount"=>"10", "CARDNO"=>"", "PM"=>"iDEAL", "STATUS"=>"2", "IP"=>"83.68.2.74", "TRXDATE"=>"02/19/09", "NCERROR"=>"30001001", "ED"=>"", "SHASIGN"=>"BC9E821662DFD1EBC6E23BF044F6957796076B80", "currency"=>"EUR"}
    )
  end
end

describe "AbnAmro::Internetkassa::Response, with a cancelled payment" do
  before do
    @response = AbnAmro::Internetkassa::Response.new(
    {"CN"=>"", "BRAND"=>"iDEAL", "orderID"=>"1235052559", "PAYID"=>"3051681", "action"=>"index", "ACCEPTANCE"=>"", "controller"=>"payments", "amount"=>"10", "CARDNO"=>"", "PM"=>"iDEAL", "STATUS"=>"2", "IP"=>"83.68.2.74", "TRXDATE"=>"02/19/09", "NCERROR"=>"30171001", "ED"=>"", "SHASIGN"=>"734AB5AD3033C46E1F69CBFB91EDD0AD34E7368D", "currency"=>"EUR"}
    )
  end
end

describe "AbnAmro::Internetkassa::Response, when an exception occurred" do
  before do
    @response = AbnAmro::Internetkassa::Response.new(
    {"CN"=>"", "BRAND"=>"iDEAL", "orderID"=>"1235052396", "PAYID"=>"3051657", "action"=>"index", "ACCEPTANCE"=>"", "controller"=>"payments", "amount"=>"10", "CARDNO"=>"", "PM"=>"iDEAL", "STATUS"=>"92", "IP"=>"83.68.2.74", "TRXDATE"=>"02/19/09", "NCERROR"=>"20002001", "ED"=>"", "SHASIGN"=>"614F540CC51607DA44CB8D2403B8DF1781B9712C", "currency"=>"EUR"}
    )
  end
end