require 'rubygems' rescue LoadError
require 'test/spec'
require 'mocha'

require File.expand_path('../helpers/view_helper', __FILE__)

$:.unshift File.expand_path('../../lib', __FILE__)
require 'abn-amro/internetkassa'
require 'abn-amro/internetkassa_helpers'

AbnAmro::Internetkassa.test = true
AbnAmro::Internetkassa.merchant_id = 'fingertips'
AbnAmro::Internetkassa.passphrase = 'supersecret'