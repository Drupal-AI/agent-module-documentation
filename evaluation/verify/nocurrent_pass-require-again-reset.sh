#!/usr/bin/env bash
# Execution RESET: force requirement OFF (disabled=TRUE) so verify FAILS until the agent re-enables the requirement. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("nocurrent_pass.settings")->set("nocurrent_pass_disabled", TRUE)->save();' >/dev/null 2>&1
echo "nocurrent_pass.settings:nocurrent_pass_disabled set to TRUE"
