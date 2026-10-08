#!/usr/bin/env bash
# Introspection CLEANUP: clear the enabled-entities config back to empty. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("breadcrumb_extra_field.settings")
    ->set("breadcrumb_extra_field_admin", [])->save();
  \Drupal\Core\Cache\Cache::invalidateTags(["entity_field_info"]);
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: breadcrumb_extra_field_admin cleared"
