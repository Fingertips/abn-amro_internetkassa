require "digest/sha1"

module AbnAmro
  class Internetkassa
    class << self
      attr_accessor :pspid, :shasign, :test
      
      alias_method :merchant_id=, :pspid=
      alias_method :merchant_id,  :pspid
      
      alias_method :passphrase=,  :shasign=
      alias_method :passphrase,   :shasign
      
      def test?
        @test
      end
      
      def service_url
        test? ? TEST_URL : PRODUCTION_URL
      end
    end
    
    MANDATORY_VALUES = %w{ merchant_id order_id amount currency language }
    DEFAULT_VALUES   = { :currency => 'EUR', :language => 'nl_NL' }
    PRODUCTION_URL   = "https://internetkassa.abnamro.nl/ncol/prod/orderstandard.asp"
    TEST_URL         = "https://internetkassa.abnamro.nl/ncol/test/orderstandard.asp"
    
    attr_accessor :order_id, :amount, :description, :currency, :language
    
    def initialize(options = {})
      @options = {}
      
      DEFAULT_VALUES.merge(options).each do |k,v|
        if respond_to?("#{k}=")
          send("#{k}=", v)
        else
          @options[k] = v
        end
      end
    end
    
    def data
      verify_values!
      @options.merge(
        :PSPID => merchant_id,
        :orderID => @order_id,
        :amount => @amount,
        :currency => @currency,
        :language => @language,
        :COM => @description,
        :SHASign => signature
      )
    end
    
    private
    
    def merchant_id
      self.class.merchant_id
    end
    
    def passphrase
      self.class.passphrase
    end
    
    def verify_values!
      MANDATORY_VALUES.each do |key|
        raise ArgumentError, "`#{key}' can't be blank" if send(key).nil?
      end
    end
    
    def signature
      Digest::SHA1.hexdigest("#{@order_id}#{@amount}#{@currency}#{merchant_id}#{passphrase}")
    end
  end
end