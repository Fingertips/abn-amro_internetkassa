require 'abn-amro/internetkassa/response_codes'

module AbnAmro
  class Internetkassa
    class Response
      def initialize(params)
        @params = params
      end
      
      # attributes
      
      def order_id;       @params['orderID']                              end
      def payment_id;     @params['PAYID']                                end
      def payment_method; @params['PM']                                   end
      def acceptance;     @params['ACCEPTANCE']                           end
      def card_number;    @params['CARDNO']                               end
      def status_code;    @params['STATUS']                               end
      def error_code;     @params['NCERROR'] if @params['NCERROR'] != '0' end
      def client_ip;      @params['IP']                                   end # TODO: double check this is from client
      def signature;      @params['SHASIGN']                              end
      def currency;       @params['currency']                             end
      
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