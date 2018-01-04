$:.push File.expand_path("../lib", __FILE__)
require "docraptor-cli/version"

Gem::Specification.new do |s|
  s.name        = "docraptor-cli"
  s.version     = DocRaptorCli::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Expected Behavior"]
  s.email       = ["support@docraptor.com"]
  s.homepage    = "https://github.com/docraptor/docraptor-cli"
  s.summary     = %q{Command line interface for the DocRaptor HTML to PDF/XLS service.}
  s.description = %q{A native command line client library for the DocRaptor HTML to PDF/XLS service.}
  s.license     = "MIT"

  s.add_runtime_dependency 'docraptor', '~> 0.3.0'

  s.add_development_dependency 'bundler', '~> 1.11', '>= 1.11.2'
  s.add_development_dependency 'pry', '~> 0.10', '>= 0.10.3'
  s.add_development_dependency 'rake', '~> 11.1', '>= 11.1.2'

  s.files         = `git ls-files`.split("\n").uniq.sort.select{|f| !f.empty? }
  # s.test_files    = `git ls-files spec`.split("\n")
  s.executables   = ["docraptor"]
  s.require_paths = ["lib"]
end
