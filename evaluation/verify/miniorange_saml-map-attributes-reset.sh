#!/usr/bin/env bash
# Execution RESET: set both attribute mappings to the default NameID so verify FAILS until the agent maps
# EmailAddress/Username.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("miniorange_saml.settings")
    ->set("miniorange_saml_email_attribute", "NameID")
    ->set("miniorange_saml_username_attribute", "NameID")
    ->save();
' >/dev/null 2>&1
echo "reset: email/username attribute = NameID"
