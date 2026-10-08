#!/usr/bin/env bash
# Introspection SETUP: set known global filebrowser defaults so an agent can read them back:
# download_manager=public and download_archive=1. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $c = \Drupal::configFactory()->getEditable("filebrowser.settings");
  $c->set("filebrowser.rights.download_manager","public");
  $c->set("filebrowser.rights.download_archive",1);
  $c->save();
' >/dev/null 2>&1
echo "setup: filebrowser.settings download_manager=public, download_archive=1"
