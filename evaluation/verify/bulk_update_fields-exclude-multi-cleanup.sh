#!/usr/bin/env bash
# Execution CLEANUP: restore baseline (empty exclude list). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("bulk_update_fields.settings")
    ->set("exclude", [])->save();
' >/dev/null 2>&1
echo "cleanup: bulk_update_fields.settings exclude reset to []"
