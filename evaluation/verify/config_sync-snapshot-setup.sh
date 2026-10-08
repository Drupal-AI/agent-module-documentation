#!/usr/bin/env bash
# Introspection SETUP: ensure config_sync has a config snapshot for the external_link_popup
# module (snapshot set 'config_sync'), so an inspecting agent can find it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\config_sync\ConfigSyncSnapshotterInterface;
  \Drupal::service("config_sync.snapshotter")->refreshExtensionSnapshot("module", ["external_link_popup"], ConfigSyncSnapshotterInterface::SNAPSHOT_MODE_INSTALL);
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: config_sync snapshot present for module external_link_popup"
