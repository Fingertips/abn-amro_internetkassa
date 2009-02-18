module AbnAmro
  class Internetkassa
    PRODUCTION_URL = "https://internetkassa.abnamro.nl/ncol/prod/orderstandard.asp"
    TEST_URL       = "https://internetkassa.abnamro.nl/ncol/test/orderstandard.asp"
    
    class << self
      attr_accessor :pspid, :test
      
      alias_method :merchant_id=, :pspid=
      alias_method :merchant_id,  :pspid
      
      def test?
        @test
      end
      
      def service_url
        test? ? TEST_URL : PRODUCTION_URL
      end
    end
    
    attr_accessor :order_id, :amount, :description
    
    def initialize(options = {})
      options.each { |k,v| send("#{k}=", v) }
    end
  end
end