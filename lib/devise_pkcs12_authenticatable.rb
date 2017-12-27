# frozen_string_literal: true

require 'devise'

require 'devise_pkcs12_authenticatable/railtie' if defined?(::Rails::Railtie)

module Devise
  # Name of the field for 'commonName'
  mattr_accessor :pkcs12_common_name_field
  @@pkcs12_common_name_field = :cn # rubocop:disable Style/ClassVars
end

Devise.add_module(:pkcs12_authenticatable, route: :session,
                                           controller: :sessions,
                                           strategy: true,
                                           model: 'devise_pkcs12_authenticatable/model')
