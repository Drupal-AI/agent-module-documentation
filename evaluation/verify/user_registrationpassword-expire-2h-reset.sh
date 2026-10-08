#!/usr/bin/env bash
# Execution RESET: force activation-link expiry OFF with default timeout, so verify FAILS until the
# agent enables expiry at 7200s. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("user_registrationpassword.settings")->set("registration_ftll_expire",FALSE)->set("registration_ftll_timeout",86400)->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: registration_ftll_expire=false timeout=86400"
