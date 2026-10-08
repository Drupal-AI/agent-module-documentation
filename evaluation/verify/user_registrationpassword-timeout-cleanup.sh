#!/usr/bin/env bash
# Restore shipped defaults (expire=false, timeout=86400). Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("user_registrationpassword.settings")->set("registration_ftll_expire",FALSE)->set("registration_ftll_timeout",86400)->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: activation link settings restored to defaults"
