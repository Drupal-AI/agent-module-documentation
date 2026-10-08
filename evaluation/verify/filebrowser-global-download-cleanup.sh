#!/usr/bin/env bash
# Introspection CLEANUP: restore shipped filebrowser defaults (download_manager=private,
# download_archive=0). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $c = \Drupal::configFactory()->getEditable("filebrowser.settings");
  $c->set("filebrowser.rights.download_manager","private");
  $c->set("filebrowser.rights.download_archive",0);
  $c->save();
' >/dev/null 2>&1
echo "cleanup: filebrowser.settings restored (download_manager=private, download_archive=0)"
