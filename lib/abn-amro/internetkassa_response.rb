module AbnAmro
  class Internetkassa
    class Response
      def initialize(params)
        @params = params
      end
      
      def success?
        @params['STATUS'] == '9'
      end
    end
  end
end