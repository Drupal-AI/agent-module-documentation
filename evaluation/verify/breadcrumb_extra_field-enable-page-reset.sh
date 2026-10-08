#!/usr/bin/env bash
# Execution RESET: clear breadcrumb_extra_field_admin config so node/page is NOT enabled; verify
# FAILS until the agent enables it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("breadcrumb_extra_field.settings")
    ->set("breadcrumb_extra_field_admin", [])->save();
  \Drupal\Core\Cache\Cache::invalidateTags(["entity_field_info"]);
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: breadcrumb_extra_field_admin empty"
