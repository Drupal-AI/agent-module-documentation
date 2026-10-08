#!/usr/bin/env bash
# Introspection SETUP: create a namespaced menu we_mm_menu, seed a We Mega Menu layout for it
# under the default theme, and force its dropdowns to open on CLICK (block_config.action=clicked)
# with a fadeInUp animation, so an inspecting agent can read back the stored behavior. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\system\Entity\Menu;
  if (!Menu::load("we_mm_menu")) {
    Menu::create(["id" => "we_mm_menu", "label" => "WE MM Menu"])->save();
  }
  $theme = \Drupal::config("system.theme")->get("default");
  \Drupal\we_megamenu\WeMegaMenuBuilder::initMegamenu("we_mm_menu", $theme);
  $cfg = \Drupal\we_megamenu\WeMegaMenuBuilder::loadConfig("we_mm_menu", $theme);
  $cfg->block_config->action = "clicked";
  $cfg->block_config->animation = "fadeInUp";
  \Drupal\we_megamenu\WeMegaMenuBuilder::saveConfig("we_mm_menu", $theme, json_encode($cfg));
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: we_mm_menu megamenu stored with block_config.action=clicked, animation=fadeInUp"
