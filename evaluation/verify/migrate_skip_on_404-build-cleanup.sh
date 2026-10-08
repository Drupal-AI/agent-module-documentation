#!/usr/bin/env bash
# Execution CLEANUP (migrate_skip_on_404): delete the msk_task migration config entity.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  if ($m = \Drupal::entityTypeManager()->getStorage("migration")->load("msk_task")) { $m->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: migrate_plus.migration.msk_task removed"
