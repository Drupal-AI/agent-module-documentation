#!/usr/bin/env bash
# Introspection CLEANUP: restore the default email attribute (NameID).
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("miniorange_saml.settings")
    ->set("miniorange_saml_email_attribute", "NameID")->save();
' >/dev/null 2>&1
echo "cleanup: miniorange_saml_email_attribute restored to NameID"
