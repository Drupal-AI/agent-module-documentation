#!/usr/bin/env bash
# Execution RESET: restore shipped defaults so verify FAILS until the agent sets the new endpoint.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("lagoon_logs.settings")->set("host","application-logs.lagoon.svc")->set("port",5140)->set("identifier","drupal")->set("disable",0)->save();' >/dev/null 2>&1
echo "reset: lagoon_logs.settings at defaults (host=application-logs.lagoon.svc port=5140)"
