#!/usr/bin/env bash
# Execution RESET: force TacJS enabled=TRUE (shipped baseline) so verify FAILS until the agent
# disables the banner site-wide.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("tacjs.settings")->set("enabled",TRUE)->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: tacjs.settings enabled=true"
