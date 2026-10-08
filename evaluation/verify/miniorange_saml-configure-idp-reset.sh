#!/usr/bin/env bash
# Execution RESET: clear the IdP config so verify FAILS until the agent configures it.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("miniorange_saml.settings")
    ->set("miniorange_saml_idp_name", "")
    ->set("miniorange_saml_idp_issuer", "")
    ->set("miniorange_saml_idp_login_url", "")
    ->save();
' >/dev/null 2>&1
echo "reset: IdP name/issuer/login_url cleared"
