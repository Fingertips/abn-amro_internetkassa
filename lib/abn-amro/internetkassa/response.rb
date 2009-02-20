require 'abn-amro/internetkassa/response_codes'

module AbnAmro
  class Internetkassa
    class Response
      attr_reader :params
      
      def initialize(params)
        @params = params
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
      
      def success?
        error_code.nil?
      end
      
      def retry?
        Codes::ERROR_CODES[error_code][:retry] if error_code
      end
      
      def error_message
        Codes::ERROR_CODES[error_code][:explanation] if error_code
      end
    end
  end
end