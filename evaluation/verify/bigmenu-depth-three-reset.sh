#!/usr/bin/env bash
# Execution RESET for the "bigmenu depth = 3" task: put max_depth at the install default (1),
# which is NOT the target (3), so verify fails on the reset state until the agent configures it.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("bigmenu.settings")->set("max_depth", 1)->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: bigmenu.settings max_depth = 1 (target is 3)"
