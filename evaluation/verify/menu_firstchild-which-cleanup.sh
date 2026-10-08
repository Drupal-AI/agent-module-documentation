#!/usr/bin/env bash
# Introspection CLEANUP: remove the two fixture menu links. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $storage = \Drupal::entityTypeManager()->getStorage("menu_link_content");
  foreach (["MFC Enabled Link", "MFC Plain Link"] as $title) {
    foreach ($storage->loadByProperties(["title" => $title]) as $l) { $l->delete(); }
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: MFC Enabled Link / MFC Plain Link removed"
