#!/usr/bin/env bash
# Execution RESET: clear all enabled TacJS services (baseline) so verify FAILS until the agent
# enables the youtube service.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("tacjs.settings")->set("services",[])->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: tacjs.settings services=[] (youtube not enabled)"
