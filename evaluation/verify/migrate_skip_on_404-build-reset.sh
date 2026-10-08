#!/usr/bin/env bash
# Execution RESET (migrate_skip_on_404): ensure the target migration msk_task does NOT exist,
# so verify FAILS until the agent builds it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  if ($m = \Drupal::entityTypeManager()->getStorage("migration")->load("msk_task")) { $m->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: migrate_plus.migration.msk_task absent"
