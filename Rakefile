require 'rake/testtask'

namespace :gem do
  directory 'pkg'
  
  desc 'Build the gem'
  task :build => :pkg do
    sh 'gem build internetkassa.gemspec'
    sh 'mv internetkassa-*.gem pkg/'
  end
  
  desc 'Install the gem'
  task :install => :build do
    sh 'sudo gem install pkg/internetkassa-*.gem'
  end
end

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
      :order_id => Time.now.to_i,
      :amount => 1031,
      :description => "HappyHardcore vol. 123 - the ballads",
      :endpoint_url => ENV['URL'] || "http://example.com/payments",
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