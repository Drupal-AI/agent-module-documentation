#!/usr/bin/env bash
# Introspection SETUP: seed a known external IdP configuration so the agent can read the SSO URL back.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("miniorange_saml.settings")
    ->set("miniorange_saml_idp_name", "Acme Okta SSO")
    ->set("miniorange_saml_idp_issuer", "http://www.okta.com/acme-mo-known")
    ->set("miniorange_saml_idp_login_url", "https://acme.okta.com/app/mo-known/sso/saml")
    ->set("miniorange_saml_enable_login", TRUE)
    ->save();
' >/dev/null 2>&1
echo "setup: seeded IdP (login_url=https://acme.okta.com/app/mo-known/sso/saml)"
