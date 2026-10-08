#!/usr/bin/env bash
# Introspection CLEANUP: delete the jmi_probe menu and its links. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\system\Entity\Menu;
  $links = \Drupal::entityTypeManager()->getStorage("menu_link_content")->loadByProperties(["menu_name" => "jmi_probe"]);
  foreach ($links as $l) { $l->delete(); }
  if ($m = Menu::load("jmi_probe")) { $m->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: menu jmi_probe removed"
