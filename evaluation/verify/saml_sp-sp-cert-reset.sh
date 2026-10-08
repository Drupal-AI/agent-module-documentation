#!/usr/bin/env bash
# Execution RESET: clear the SP cert_location/key_location in saml_sp.settings so verify FAILS
# until the agent sets them. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("saml_sp.settings")->set("cert_location", "")->set("key_location", "")->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: saml_sp.settings cert_location/key_location cleared"
