# frozen_string_literal: true

require 'active_support/concern'
require 'devise_pkcs12_authenticatable/strategy'

module Devise
  module Models
    module PKCS12Authenticatable
      extend ActiveSupport::Concern
      include Devise::Models::DatabaseAuthenticatable

      def valid_common_name?(common_name)
        return false if self[::Devise.pkcs12_common_name_field].blank?
        self[::Devise.pkcs12_common_name_field] == common_name
      end

      module ClassMethods
        def find_for_pkcs12_authentication(conditions)
          find_for_authentication(conditions)
        end
      end
    end
  end
end
