#!/usr/bin/env bash
# Execution RESET: ensure the module is ENABLED (disable=0) so verify FAILS until the agent disables it.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("lagoon_logs.settings")->set("host","application-logs.lagoon.svc")->set("port",5140)->set("identifier","drupal")->set("disable",0)->save();' >/dev/null 2>&1
echo "reset: lagoon_logs disable=0 (logging active)"
