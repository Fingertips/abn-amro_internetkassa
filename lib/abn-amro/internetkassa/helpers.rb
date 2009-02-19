module AbnAmro
  class Internetkassa
    module Helpers
      def internetkassa_form_tag(internetkassa_instance, &block)
        form_tag(AbnAmro::Internetkassa.service_url) do
          result = internetkassa_instance.data.map { |name, value| hidden_field_tag(name, value, :id => nil) }
          result << capture(&block) if block_given?
          "\n#{result.join("\n")}\n"
        end
      end
    end
  end
end