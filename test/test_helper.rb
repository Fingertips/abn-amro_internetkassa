require 'rubygems' rescue LoadError
require 'test/spec'
require 'mocha'

require 'action_controller'
require 'action_view'
require 'action_view/test_case'

$:.unshift File.expand_path('../../lib', __FILE__)
require 'abn-amro/internetkassa'
require 'abn-amro/internetkassa_helpers'

AbnAmro::Internetkassa.test = true
AbnAmro::Internetkassa.pspid = 'fingertips'