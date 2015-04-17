require 'devise/strategies/database_authenticatable'

module Devise
  module Strategies
    class PKCS12Authenticatable < DatabaseAuthenticatable
      def authenticate!
        opts = authentication_hash.merge(Hash[::Devise.pkcs12_common_name_field, common_name])
        resource  = password.present? && mapping.to.find_for_pkcs12_authentication(opts)
        encrypted = false

        if validate(resource){ encrypted = true; resource.valid_password?(password) } && resource.valid_common_name?(common_name)
          remember_me(resource)
          resource.after_database_authentication
          success!(resource)
        end

        mapping.to.new.password = password if !encrypted && Devise.paranoid
        fail!(:not_found_in_database) unless resource
      end

      def valid?
        super && client_verify?
      end

      protected

      def common_name
        request.headers['X-SSL-CLIENT-S-DN'].split('/').last.split('=').last.strip
      end

      def client_verify?
        case request.headers['X-CLIENT-VERIFY'].upcase
        when 'SUCCESS'
          true
        else
          false
        end
      end
    end
  end
end

Warden::Strategies.add(:pkcs12_authenticatable, Devise::Strategies::PKCS12Authenticatable)