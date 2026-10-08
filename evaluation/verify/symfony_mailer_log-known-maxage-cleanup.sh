#!/usr/bin/env bash
# Introspection CLEANUP: restore the shipped symfony_mailer_log.settings defaults
# (enable=true, max_age=null, batch_size=100). Idempotent. Exit 0.
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
echo "cleanup: symfony_mailer_log.settings restored to defaults"
