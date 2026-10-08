#!/usr/bin/env bash
# Execution RESET: clear ebt_core_secondary_color to a baseline (empty) so verify FAILS until
# the agent sets it to #ff8800. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("ebt_core.settings")->set("ebt_core_secondary_color","")->save();' >/dev/null 2>&1
echo "reset: ebt_core_secondary_color cleared (empty)"
