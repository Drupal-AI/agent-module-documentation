#!/usr/bin/env bash
# Introspection SETUP: enable activation-link expiry with a known 3600s timeout. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("user_registrationpassword.settings")->set("registration_ftll_expire",TRUE)->set("registration_ftll_timeout",3600)->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: registration_ftll_expire=true registration_ftll_timeout=3600"
