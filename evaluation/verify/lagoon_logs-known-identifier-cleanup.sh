#!/usr/bin/env bash
# Introspection CLEANUP: restore shipped defaults. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("lagoon_logs.settings")->set("host","application-logs.lagoon.svc")->set("port",5140)->set("identifier","drupal")->set("disable",0)->save();' >/dev/null 2>&1
echo "cleanup: lagoon_logs.settings restored to defaults"
