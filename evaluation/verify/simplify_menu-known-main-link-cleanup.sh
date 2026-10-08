#!/usr/bin/env bash
# Introspection CLEANUP: remove the 'SM Eval Portal' main-menu link created by the matching
# setup and restore the menu tree to baseline. Idempotent. Exits 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("menu_link_content");
  foreach ($s->loadByProperties(["title" => "SM Eval Portal"]) as $l) { $l->delete(); }
  \Drupal::service("plugin.manager.menu.link")->rebuild();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: removed main-menu link 'SM Eval Portal'"
