# frozen_string_literal: true

lib = File.expand_path('../lib', __FILE__)

$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'devise_pkcs12_authenticatable/version'

Gem::Specification.new do |spec|
  spec.name          = 'devise_pkcs12_authenticatable'
  spec.version       = DevisePKCS12Authenticatable::VERSION.dup
  spec.author        = 'Alexander Grigoriev'
  spec.email         = 'a.grigorev007@gmail.com'

  spec.summary       = 'PKCS #12 authentication for Devise.'
  spec.description   = 'PKCS #12 authentication for Devise.'
  spec.homepage      = 'https://github.com/vill/devise_pkcs12_authenticatable'
  spec.license       = 'MIT'

  spec.require_paths = ['lib']
  spec.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end

  spec.required_ruby_version     = '>= 1.9.3'
  spec.required_rubygems_version = '>= 2.2.0'

  spec.add_dependency 'activesupport', '~> 4.1.8'
  spec.add_dependency 'devise',        '~> 3.4.1'
  spec.add_dependency 'railties',      '~> 4.1.8'

  spec.add_development_dependency 'bundler', '~> 1.9'
  spec.add_development_dependency 'rake',    '~> 10.0'
  spec.add_development_dependency 'rubocop', '~> 0.51.0'
end
