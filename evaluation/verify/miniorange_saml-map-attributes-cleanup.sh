#!/usr/bin/env bash
# Execution CLEANUP: restore both attribute mappings to the default NameID.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("miniorange_saml.settings")
    ->set("miniorange_saml_email_attribute", "NameID")
    ->set("miniorange_saml_username_attribute", "NameID")
    ->save();
' >/dev/null 2>&1
echo "cleanup: email/username attribute restored to NameID"
