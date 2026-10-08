#!/usr/bin/env bash
# Introspection SETUP: set a known log retention period (1 week = 604800s) on
# mail_safety.settings so the agent can read it back. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("mail_safety.settings")
    ->set("log_retention_period", 604800)
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: mail_safety log_retention_period=604800"
