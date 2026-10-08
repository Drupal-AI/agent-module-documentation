#!/usr/bin/env bash
# Execution RESET for the "bigmenu top-level only" task: set max_depth to 6 (a NON-target value),
# so verify (which wants 1) fails on the reset state until the agent sets it to the shallowest depth.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("bigmenu.settings")->set("max_depth", 6)->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: bigmenu.settings max_depth = 6 (target is 1)"
