#!/usr/bin/env bash
# Execution CLEANUP: remove the MFC Build Parent fixture link. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $storage = \Drupal::entityTypeManager()->getStorage("menu_link_content");
  foreach ($storage->loadByProperties(["title" => "MFC Build Parent"]) as $l) { $l->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: MFC Build Parent removed"
