#!/usr/bin/env bash
# Execution RESET: restore the shipped code defaults (security_code_length=4, timeouts=300) so
# verify FAILS until the agent sets a 6-digit code with a 600s timeout. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $c = \Drupal::configFactory()->getEditable("email_tfa.settings");
  $c->set("security_code_length", 4);
  $c->set("timeouts", 300);
  $c->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: email_tfa.settings security_code_length=4 timeouts=300"
