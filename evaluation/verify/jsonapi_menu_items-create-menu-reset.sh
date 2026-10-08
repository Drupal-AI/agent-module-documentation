#!/usr/bin/env bash
# Execution RESET: ensure menu jmi_task does NOT exist (so the resource returns nothing and verify
# FAILS) until the agent creates it with a link. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\system\Entity\Menu;
  $links = \Drupal::entityTypeManager()->getStorage("menu_link_content")->loadByProperties(["menu_name" => "jmi_task"]);
  foreach ($links as $l) { $l->delete(); }
  if ($m = Menu::load("jmi_task")) { $m->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: menu jmi_task removed"
