#!/usr/bin/env bash
# Execution RESET: force memory_limit_policy.settings:header = FALSE (so verify FAILs until
# the agent turns it on). Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("memory_limit_policy.settings")->set("header", FALSE)->save();' >/dev/null 2>&1
echo "reset: memory_limit_policy.settings header=FALSE"
