# Devise PKCS #12 Authenticatable [![Gem Version](https://badge.fury.io/rb/devise_pkcs12_authenticatable.svg)](http://badge.fury.io/rb/devise_pkcs12_authenticatable)

`devise_pkcs12_authenticatable` is client side SSL certificate authentication (based on [PKCS #12](https://en.wikipedia.org/wiki/PKCS_12)) support for [Devise](https://github.com/plataformatec/devise) applications.
For authentication `devise_pkcs12_authenticatable` uses field called `CN` (Common Name) from Distinguished Name (DN) of the SSl certificate subject
and keys for any authentication mechanism from `config/initializers/devise.rb` called `config.authentication_keys`.

## Requirements

- NGINX
- Ruby 1.9.3 or greater
- Rails 4.1.8 or greater
- Devise 3.4.1 or greater

## Installation

Add this lines to your application's Gemfile:

```ruby
gem 'devise', '~> 3.4.1'
gem 'devise_pkcs12_authenticatable'
```

And then execute:

    $ bundle

## Usage

1. Setup [NGINX](http://wiki.nginx.org/Install) and [Configure HTTPS](http://nginx.org/en/docs/http/configuring_https_servers.html)

  Add next parameters to `/path/to/your/site.conf`, for example in Ubuntu your configuration file can be found here: `/etc/nginx/sites-enabled/your-site.conf`
  ```
  server {
    ...
    ssl_verify_client on;
    # Root Certificate Authority(CA) that you used to sign your client certificates
    ssl_client_certificate /path/to/your/ca.crt;
    ...

    location ... {
      ...
      proxy_set_header X-CLIENT-VERIFY   $ssl_client_verify;
      proxy_set_header X-SSL-CLIENT-S-DN $ssl_client_s_dn;
      ...
    }
  }
  ```

2. Setup [Devise](https://github.com/plataformatec/devise)

3. Setup `devise_pkcs12_authenticatable`

  Add the following to your Devise model (ie. `User.rb`):

  ```ruby
  devise :pkcs12_authenticatable # , ... and other modules, don't add :database_authenticatable as this module is intended to replace it
  ```

  Your model needs one attribute called `cn`, migration allow you to do so:

    `add_column :users, :cn, :string, null: false, index: true`

  If you need to configure `devise_pkcs12_authenticatable` then add to your config/initializers/devise.rb

  ```ruby
  Devise.setup do |config|
    ...
    # Attribute in your model for pkcs12 authentication
    config.pkcs12_common_name_field = :common_name # By default :cn
  end
  ```

## License

`devise_pkcs12_authenticatable` is released under the MIT License. See the LICENSE file for more information.