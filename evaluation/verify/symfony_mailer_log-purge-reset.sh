#!/usr/bin/env bash
# Execution RESET: restore shipped log-expiry defaults (no expiry: max_age=null, batch_size=100)
# so verify FAILS until the agent configures a 30-day / 25-per-run purge. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $c = \Drupal::configFactory()->getEditable("symfony_mailer_log.settings");
  $c->set("enable", TRUE);
  $c->set("log_expiry.max_age", NULL);
  $c->set("log_expiry.batch_size", 100);
  $c->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: symfony_mailer_log.settings expiry cleared (max_age=null, batch_size=100)"
