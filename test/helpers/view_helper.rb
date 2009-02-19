require 'action_controller'
require 'action_view'
require 'action_view/test_case'

class TestController
  attr_accessor :output_buffer
  
  def initialize
    @output_buffer = ''
  end
  
  def url_for(options)
    "http://www.example.com"
  end
  
  def protect_against_forgery?
    false
  end
end