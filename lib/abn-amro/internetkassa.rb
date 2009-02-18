module AbnAmro
  class Internetkassa
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
    
    PRODUCTION_URL = "https://internetkassa.abnamro.nl/ncol/prod/orderstandard.asp"
    TEST_URL       = "https://internetkassa.abnamro.nl/ncol/test/orderstandard.asp"
    
    MANDATORY_VALUES = %w{ merchant_id order_id amount currency language }
    DEFAULT_VALUES  = { :currency => 'EUR', :language => 'nl_NL' }
    
    attr_accessor :order_id, :amount, :description, :currency, :language
    
    def initialize(arguments = {}, options = {})
      DEFAULT_VALUES.merge(arguments).each { |k,v| send("#{k}=", v) }
      @options = options
    end
    
    def data
      verify_values!
      @options.merge(
        :PSPID => merchant_id,
        :orderID => @order_id,
        :amount => @amount,
        :currency => @currency,
        :language => @language,
        :COM => @description
      )
    end
    
    private
    
    def merchant_id
      self.class.merchant_id
    end
    
    def verify_values!
      MANDATORY_VALUES.each do |key|
        raise ArgumentError, "`#{key}' can't be blank" if send(key).nil?
      end
    end
  end
end