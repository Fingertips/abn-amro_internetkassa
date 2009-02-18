module AbnAmro
  class Internetkassa
    module Helpers
      def internetkassa_form_tag(internetkassa_instance)
        form_tag(AbnAmro::Internetkassa.service_url) do
          internetkassa_instance.data.map do |name, value|
            hidden_field_tag(name, value, :id => nil)
          end.join
        end
      end
    end
  end
end