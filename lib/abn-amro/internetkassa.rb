module AbnAmro
  class Internetkassa
    PRODUCTION_URL = "https://internetkassa.abnamro.nl/ncol/prod/orderstandard.asp"
    TEST_URL       = "https://internetkassa.abnamro.nl/ncol/test/orderstandard.asp"
    
    class << self
      attr_writer :test
      
      def test?
        @test
      end
      
      def service_url
        test? ? TEST_URL : PRODUCTION_URL
      end
    end
  end
end