#!/usr/bin/env bash
# Execution CLEANUP (daterange_compact create format): remove format dc_task. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("daterange_compact_format");
  if ($e = $s->load("dc_task")) { $e->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: dc_task removed"
