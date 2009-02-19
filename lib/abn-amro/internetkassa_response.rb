require File.expand_path('../internetkassa_response_codes', __FILE__)

module AbnAmro
  class Internetkassa
    class Response
      def initialize(params)
        @params = params
      end
      
      def success?
        @params['STATUS'] == '9'
      end
      
      def error_code
        @params['NCERROR'] unless @params['NCERROR'] == '0'
      end
      
      def error_message
        Codes::ERROR_CODES[error_code][:explanation] if error_code
      end
    end
  end
end