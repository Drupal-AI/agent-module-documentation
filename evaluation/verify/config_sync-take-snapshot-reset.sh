#!/usr/bin/env bash
# Execution RESET: delete config_sync's config snapshot for the views_migration module (snapshot set
# 'config_sync'), so verify FAILS until the agent (re)creates it via the snapshotter.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\config_snapshot\Entity\ConfigSnapshot;
  if ($s = ConfigSnapshot::load("config_sync.module.views_migration")) { $s->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: config_sync snapshot config_sync.module.views_migration removed"
