#!/usr/bin/env bash
# Execution RESET: (re)create bundle 'smm_task' with NO target menus, so verify FAILS until the
# agent makes it target the 'main' menu. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\simple_megamenu\Entity\SimpleMegaMenuType;
  if ($t = SimpleMegaMenuType::load("smm_task")) { $t->setTargetMenu([]); $t->save(); }
  else { SimpleMegaMenuType::create(["id" => "smm_task", "label" => "SMM Task", "targetMenu" => []])->save(); }
' >/dev/null 2>&1
echo "reset: simple_mega_menu_type smm_task has no target menus"
