#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("saml_sp.settings")->set("cert_location", "")->set("key_location", "")->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: saml_sp.settings cert_location/key_location cleared"
