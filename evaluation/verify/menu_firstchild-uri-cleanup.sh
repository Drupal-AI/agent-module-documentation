#!/usr/bin/env bash
# Introspection CLEANUP: remove the MFC Routeless fixture link. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $storage = \Drupal::entityTypeManager()->getStorage("menu_link_content");
  foreach ($storage->loadByProperties(["title" => "MFC Routeless"]) as $l) { $l->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: MFC Routeless removed"
