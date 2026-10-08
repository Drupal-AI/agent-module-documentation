#!/usr/bin/env bash
# Execution RESET: ensure migrate_plus.migration webform_migrate_sub_task does NOT exist (verify fails until built).
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("migration");
  if ($e = $s->load("webform_migrate_sub_task")) { $e->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: webform_migrate_sub_task absent"
