#!/usr/bin/env bash
# Introspection CLEANUP: empty the eligible bundle list. Restores baseline. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("smart_title.settings")->set("smart_title", [])->save();
  \Drupal\Core\Cache\Cache::invalidateTags(["entity_field_info"]);
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: smart_title.settings.smart_title emptied"
