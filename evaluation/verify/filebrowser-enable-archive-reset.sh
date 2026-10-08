#!/usr/bin/env bash
# Execution RESET: force global filebrowser defaults download_archive=0 and explore_subdirs=0
# so verify FAILS until the agent enables them. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $c = \Drupal::configFactory()->getEditable("filebrowser.settings");
  $c->set("filebrowser.rights.download_archive",0);
  $c->set("filebrowser.rights.explore_subdirs",0);
  $c->save();
' >/dev/null 2>&1
echo "reset: filebrowser.settings download_archive=0, explore_subdirs=0"
