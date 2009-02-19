require File.expand_path('../internetkassa_response_codes', __FILE__)

module AbnAmro
  class Internetkassa
    class Response
      def initialize(params)
        @params = params
      end
      
      def success?
        error_code.nil?
      end
      
      def retry?
        Codes::ERROR_CODES[error_code][:retry] if error_code
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