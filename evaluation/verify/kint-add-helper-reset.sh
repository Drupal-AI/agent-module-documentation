#!/usr/bin/env bash
# Execution RESET: ensure no kint.helper.kdd config exists so verify FAILS until the agent creates
# it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("kint.helper.kdd")->delete();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: kint.helper.kdd absent"
