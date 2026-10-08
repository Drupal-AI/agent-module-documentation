#!/usr/bin/env bash
# Introspection CLEANUP: restore the shipped default OTP email subject. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("email_tfa.settings")->set("subject", "One Time Password")->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: email_tfa.settings subject restored to 'One Time Password'"
