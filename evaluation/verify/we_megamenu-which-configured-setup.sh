#!/usr/bin/env bash
# Introspection SETUP: create two namespaced menus we_mm_a and we_mm_b, but store a We Mega Menu
# layout ONLY for we_mm_a. An inspecting agent must read the we_megamenu table to say which menu
# has a mega-menu configured. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\system\Entity\Menu;
  foreach (["we_mm_a" => "WE MM A", "we_mm_b" => "WE MM B"] as $id => $label) {
    if (!Menu::load($id)) { Menu::create(["id" => $id, "label" => $label])->save(); }
  }
  $theme = \Drupal::config("system.theme")->get("default");
  // Ensure only we_mm_a has a stored layout.
  \Drupal::database()->delete("we_megamenu")->condition("menu_name", "we_mm_b")->execute();
  \Drupal\we_megamenu\WeMegaMenuBuilder::initMegamenu("we_mm_a", $theme);
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: we_mm_a has a megamenu layout; we_mm_b does not"
