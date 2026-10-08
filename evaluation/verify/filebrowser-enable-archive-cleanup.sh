#!/usr/bin/env bash
# Execution CLEANUP: restore shipped filebrowser defaults (download_archive=0,
# explore_subdirs=1). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $c = \Drupal::configFactory()->getEditable("filebrowser.settings");
  $c->set("filebrowser.rights.download_archive",0);
  $c->set("filebrowser.rights.explore_subdirs",1);
  $c->save();
' >/dev/null 2>&1
echo "cleanup: filebrowser.settings restored (download_archive=0, explore_subdirs=1)"
