#!/usr/bin/env bash
# Execution RESET: ensure NO menu link titled 'MFC Build Parent' exists, so verify FAILS until
# the agent creates a first-child-enabled link. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $storage = \Drupal::entityTypeManager()->getStorage("menu_link_content");
  foreach ($storage->loadByProperties(["title" => "MFC Build Parent"]) as $l) { $l->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: MFC Build Parent absent"
