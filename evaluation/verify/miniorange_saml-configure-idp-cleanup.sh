#!/usr/bin/env bash
# Execution CLEANUP: restore shipped defaults for the IdP keys.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("miniorange_saml.settings")
    ->set("miniorange_saml_idp_name", "")
    ->set("miniorange_saml_idp_issuer", "")
    ->set("miniorange_saml_idp_login_url", "")
    ->save();
' >/dev/null 2>&1
echo "cleanup: IdP name/issuer/login_url restored to empty (default)"
