require 'rake/testtask'

Rake::TestTask.new do |t|
  t.test_files = FileList['test/**/*_test.rb']
  t.verbose = true
end

task :default => :test

namespace :test do
  desc 'Renders a simple html file which contains a internetkassa form'
  task :render do
    require File.expand_path('../test/test_helper', __FILE__)
    
    instance = AbnAmro::Internetkassa.new(
      :order_id => 123,
      :amount => 1000,
      :description => "HappyHardcore vol. 123 - the ballads",
      :TITLE => 'HappyHardcore vol. 123 - the ballads'
    )
    
    controller = TestController.new
    controller.extend(ActionView::Helpers)
    controller.extend(AbnAmro::Internetkassa::Helpers)
    
    File.open('form_test.html', 'w') do |f|
      f << %{
        <html>
          <body>
          #{controller.internetkassa_form_tag(instance) { '<input type="submit" />' }}
          </body>
        </html>
      }
    end
    
    sh 'open form_test.html'
  end
end