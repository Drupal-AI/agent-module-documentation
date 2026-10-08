#!/usr/bin/env bash
# Introspection CLEANUP: delete the 'Micon Menu Med' menu link. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  foreach (\Drupal::entityTypeManager()->getStorage("menu_link_content")->loadByProperties(["title"=>"Micon Menu Med"]) as $m) { $m->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: 'Micon Menu Med' removed"
