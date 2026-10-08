#!/usr/bin/env bash
# Execution CLEANUP: remove the MFC Task Parent + MFC Task Child fixture links. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $storage = \Drupal::entityTypeManager()->getStorage("menu_link_content");
  foreach (["MFC Task Parent", "MFC Task Child"] as $title) {
    foreach ($storage->loadByProperties(["title" => $title]) as $l) { $l->delete(); }
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: MFC Task Parent / MFC Task Child removed"
