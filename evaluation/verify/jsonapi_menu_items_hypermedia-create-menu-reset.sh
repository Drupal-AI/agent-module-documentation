#!/usr/bin/env bash
# Execution RESET: ensure menu jmih_task does NOT exist so verify FAILS until the agent creates it
# with a link (so the submodule would advertise menu_items--jmih_task). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\system\Entity\Menu;
  $links = \Drupal::entityTypeManager()->getStorage("menu_link_content")->loadByProperties(["menu_name" => "jmih_task"]);
  foreach ($links as $l) { $l->delete(); }
  if ($m = Menu::load("jmih_task")) { $m->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: menu jmih_task removed"
