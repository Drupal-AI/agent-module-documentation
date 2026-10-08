#!/usr/bin/env bash
# Execution RESET: force email logging OFF (enable=false) so verify FAILS until the agent turns
# it back on. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("symfony_mailer_log.settings")->set("enable", FALSE)->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: symfony_mailer_log.settings enable=FALSE"
