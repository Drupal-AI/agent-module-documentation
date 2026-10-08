#!/usr/bin/env bash
# Execution RESET: empty the Smart Title eligible bundle list so verify FAILS until the agent
# makes node:article eligible (as the Smart Title UI settings form would). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("smart_title.settings")->set("smart_title", [])->save();
  \Drupal\Core\Cache\Cache::invalidateTags(["entity_field_info"]);
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: smart_title.settings.smart_title emptied"
