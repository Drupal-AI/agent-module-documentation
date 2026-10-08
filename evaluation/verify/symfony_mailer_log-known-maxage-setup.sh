#!/usr/bin/env bash
# Introspection SETUP: set a known log-expiry retention on symfony_mailer_log.settings so an
# inspecting agent can read it back. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $c = \Drupal::configFactory()->getEditable("symfony_mailer_log.settings");
  $c->set("enable", TRUE);
  $c->set("log_expiry.max_age", "P2W");
  $c->set("log_expiry.batch_size", 100);
  $c->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: symfony_mailer_log.settings log_expiry.max_age=P2W"
