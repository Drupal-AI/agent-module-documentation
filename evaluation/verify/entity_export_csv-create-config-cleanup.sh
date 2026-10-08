#!/usr/bin/env bash
# Execution CLEANUP: delete the eec_task config entity. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("entity_export_csv");
  if ($e = $s->load("eec_task")) { $e->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: eec_task removed"
