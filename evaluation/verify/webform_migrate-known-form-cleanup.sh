#!/usr/bin/env bash
# CLEANUP: delete migrate_plus.migration config entity wm_known_form. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("migration");
  if ($e = $s->load("wm_known_form")) { $e->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: wm_known_form removed"
