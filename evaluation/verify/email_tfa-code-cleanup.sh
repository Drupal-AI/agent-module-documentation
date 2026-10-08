#!/usr/bin/env bash
# Execution CLEANUP: restore shipped code defaults (security_code_length=4, timeouts=300). Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $c = \Drupal::configFactory()->getEditable("email_tfa.settings");
  $c->set("security_code_length", 4);
  $c->set("timeouts", 300);
  $c->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: email_tfa.settings security_code_length=4 timeouts=300"
