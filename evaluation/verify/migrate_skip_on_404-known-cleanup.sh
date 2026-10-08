#!/usr/bin/env bash
# Introspection CLEANUP (migrate_skip_on_404): delete the msk_known migration config entity.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  if ($m = \Drupal::entityTypeManager()->getStorage("migration")->load("msk_known")) { $m->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: migrate_plus.migration.msk_known removed"
