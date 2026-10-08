#!/usr/bin/env bash
# Execution RESET: force Simple Less compilation OFF (clear the ipless mapping) so verify FAILS
# until the agent enables it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("system.performance")->clear("ipless")->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: system.performance ipless cleared (compilation disabled)"
