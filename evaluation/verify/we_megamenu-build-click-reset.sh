#!/usr/bin/env bash
# Execution RESET: ensure the namespaced menu we_mm_menu exists but has NO We Mega Menu layout
# stored (delete any we_megamenu rows for it), so verify FAILS until the agent builds one.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\system\Entity\Menu;
  if (!Menu::load("we_mm_menu")) {
    Menu::create(["id" => "we_mm_menu", "label" => "WE MM Menu"])->save();
  }
  \Drupal::database()->delete("we_megamenu")->condition("menu_name", "we_mm_menu")->execute();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: we_mm_menu exists with no megamenu layout stored"
