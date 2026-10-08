#!/usr/bin/env bash
# Cleanup: remove the ly_probe remote_video display and the ly_probe media view mode. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $etm = \Drupal::entityTypeManager()->getStorage("entity_view_display");
  if ($vd = $etm->load("media.remote_video.ly_probe")) { $vd->delete(); }
  $vms = \Drupal::entityTypeManager()->getStorage("entity_view_mode");
  if ($vm = $vms->load("media.ly_probe")) { $vm->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: ly_probe display + view mode removed"
