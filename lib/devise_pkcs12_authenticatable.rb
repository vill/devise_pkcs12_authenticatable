require 'devise'
require 'active_support'
require 'active_support/inflector'
require 'active_support/concern'

require 'devise_pkcs12_authenticatable/engine'

module DevisePKCS12Authenticatable
end

module Devise
  # Name of the field for 'commonName'
  mattr_accessor :pkcs12_common_name_field
  @@pkcs12_common_name_field = :cn
end

Devise.add_module(:pkcs12_authenticatable,
  route: :session,
  controller: :sessions,
  strategy: true,
  model: 'devise_pkcs12_authenticatable/model'
)