#!/usr/bin/env bash
# Execution RESET: set the number of tac_lite schemes to 1, so verify FAILS until the agent
# increases it to 2. Config-only. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("tac_lite.settings")->set("tac_lite_schemes", 1)->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: tac_lite_schemes=1"
