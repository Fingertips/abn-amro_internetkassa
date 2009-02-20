require 'abn-amro/internetkassa'
require 'abn-amro/internetkassa/helpers'

ActionView::Base.send(:include, AbnAmro::Internetkassa::Helpers)