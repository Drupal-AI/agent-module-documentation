#!/usr/bin/env bash
# Execution CLEANUP: ensure config_sync's snapshot for the views_migration module is restored to
# baseline (present). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\config_sync\ConfigSyncSnapshotterInterface;
  \Drupal::service("config_sync.snapshotter")->refreshExtensionSnapshot("module", ["views_migration"], ConfigSyncSnapshotterInterface::SNAPSHOT_MODE_INSTALL);
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: config_sync snapshot for views_migration restored"
