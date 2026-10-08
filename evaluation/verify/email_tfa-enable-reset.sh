#!/usr/bin/env bash
# Execution RESET: force Email TFA OFF (status=false) with the default global track, so verify
# FAILS until the agent enables it globally. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $c = \Drupal::configFactory()->getEditable("email_tfa.settings");
  $c->set("status", FALSE);
  $c->set("tracks", "globally_enabled");
  $c->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: email_tfa.settings status=FALSE"
