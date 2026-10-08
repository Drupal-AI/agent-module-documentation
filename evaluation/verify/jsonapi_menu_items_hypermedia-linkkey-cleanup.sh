#!/usr/bin/env bash
# Introspection CLEANUP: delete the jmih_two menu and its links. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\system\Entity\Menu;
  $links = \Drupal::entityTypeManager()->getStorage("menu_link_content")->loadByProperties(["menu_name" => "jmih_two"]);
  foreach ($links as $l) { $l->delete(); }
  if ($m = Menu::load("jmih_two")) { $m->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: menu jmih_two removed"
