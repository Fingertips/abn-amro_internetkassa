require 'abn-amro/internetkassa/response_codes'

module AbnAmro
  class Internetkassa
    class Response
      class SignatureInvalidError < StandardError; end
      
      attr_reader :params
      
      def initialize(params)
        @params = params
        
        unless valid?
          raise SignatureInvalidError, "signature `#{signature}' does not match the signature calculated for this message `#{calculated_signature}'"
        end
      end
      
      # attributes
      
      def order_id;             @params['orderID']                              end
      def payment_id;           @params['PAYID']                                end
      def payment_method;       @params['PM']                                   end
      def acceptance;           @params['ACCEPTANCE']                           end
      def currency;             @params['currency']                             end
      def status_code;          @params['STATUS']                               end
      def error_code;           @params['NCERROR'] if @params['NCERROR'] != '0' end
      def signature;            @params['SHASIGN']                              end
      def customer_name;        @params['CN']                                   end
      def card_brand;           @params['BRAND']                                end
      def card_number;          @params['CARDNO']                               end
      def card_expiration_date; @params['ED']                                   end
      
      def amount
        @amount ||= (@params['amount'].to_f * 100).to_i
      end
      
      def transaction_date
        @transaction_date ||= Date.parse(@params['TRXDATE'], true)
      end
      
      # methods
      
      def valid?
        signature == calculated_signature
      end
      
      def success?
        error_code.nil?
      end
      
      def retry?
        Codes::ERROR_CODES[error_code][:retry] if error_code
      end
      
      def error_message
        Codes::ERROR_CODES[error_code][:explanation] if error_code
      end
      
      private
      
      def calculated_signature
        message = ''
        message << order_id
        message << currency
        message << @params['amount']
        message << payment_method
        message << acceptance
        message << status_code
        message << card_number
        message << payment_id
        message << @params['NCERROR']
        message << card_brand
        message << Internetkassa.passphrase
        
        Digest::SHA1.hexdigest(message).upcase
      end
    end
  end
end