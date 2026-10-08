#!/usr/bin/env bash
# Execution CLEANUP: delete the jmih_edit menu and its links. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\system\Entity\Menu;
  $links = \Drupal::entityTypeManager()->getStorage("menu_link_content")->loadByProperties(["menu_name" => "jmih_edit"]);
  foreach ($links as $l) { $l->delete(); }
  if ($m = Menu::load("jmih_edit")) { $m->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: menu jmih_edit removed"
