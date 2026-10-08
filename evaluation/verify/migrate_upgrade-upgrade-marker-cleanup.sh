#!/usr/bin/env bash
# Introspection CLEANUP: delete the migrate_drupal_ui.performed state marker set by the
# matching setup, restoring a clean (no-upgrade-performed) baseline. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::state()->delete("migrate_drupal_ui.performed");
' >/dev/null 2>&1
echo "cleanup: state migrate_drupal_ui.performed deleted"
