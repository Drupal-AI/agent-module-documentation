#!/usr/bin/env bash
# Execution CLEANUP: remove the we_mm_menu megamenu rows and the menu itself.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\system\Entity\Menu;
  \Drupal::database()->delete("we_megamenu")->condition("menu_name", "we_mm_menu")->execute();
  if ($m = Menu::load("we_mm_menu")) { $m->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: removed we_mm_menu and its megamenu rows"
