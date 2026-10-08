#!/usr/bin/env bash
# Execution RESET: force all_forms OFF (shipped baseline) so verify FAILS until the agent turns
# on "Submit all forms to secure URL".
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("securelogin.settings")->set("all_forms",FALSE)->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: securelogin.settings all_forms=false"
