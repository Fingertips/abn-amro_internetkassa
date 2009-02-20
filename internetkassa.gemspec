Gem::Specification.new do |spec|
  spec.name = 'internetkassa'
  spec.version = '0.9.0'
  
  spec.homepage = 'https://github.com/Fingertips/abn-amro_internetkassa/tree/master'
  spec.description = spec.summary = %{
    A library to make online payments using ABN-AMRO (Dutch bank) Internetkassa.
  }
  
  spec.author = 'Eloy Duran'
  spec.email = 'eloy@fngtps.com'
  
  spec.files = Dir['lib/**/*.rb', 'bin/*', '[A-Z]*', 'test/**/*', 'init.rb']
  
  spec.has_rdoc = true
  spec.extra_rdoc_files = %w{ README.rdoc LICENSE }
  spec.rdoc_options << '--charset=utf-8' << '--main=README.rdoc'
  
  if spec.respond_to?(:add_development_dependency)
    spec.add_development_dependency 'test-spec'
    spec.add_development_dependency 'mocha'
  end
end