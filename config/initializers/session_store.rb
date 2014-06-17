# Be sure to restart your server when you modify this file.

if Rails.env.production?
  ManifesteSe::Application.config.session_store :cookie_store, key: '_meurio_accounts_session', domain: 'minhascidades.org.br', expire_after: 100.years
elsif Rails.env.staging?
  ManifesteSe::Application.config.session_store :cookie_store, key: '_meurio_accounts_session', domain: 'meurio-staging.org.br', expire_after: 100.years
else
  ManifesteSe::Application.config.session_store :cookie_store, key: '_meurio_accounts_session', expire_after: 100.years
end

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rails generate session_migration")
# ManifesteSe::Application.config.session_store :active_record_store
