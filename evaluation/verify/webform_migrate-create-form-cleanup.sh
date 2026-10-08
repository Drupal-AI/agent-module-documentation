#!/usr/bin/env bash
# CLEANUP: delete migrate_plus.migration config entity webform_migrate_task. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("migration");
  if ($e = $s->load("webform_migrate_task")) { $e->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: webform_migrate_task removed"
