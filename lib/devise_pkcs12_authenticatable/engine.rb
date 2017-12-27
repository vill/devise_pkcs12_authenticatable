# frozen_string_literal: true

module PKCS12Authenticatable
  class Engine < ::Rails::Engine
    ActiveSupport::Inflector.inflections(:en) do |inflect|
      inflect.acronym 'PKCS12'
    end
  end
end
