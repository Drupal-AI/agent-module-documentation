#!/usr/bin/env bash
# Execution RESET: ensure the namespaced menu we_mm_menu2 exists (so its derivative block
# we_megamenu_block:we_mm_menu2 is available) and delete any placed block using that plugin, so
# verify FAILS until the agent places the Mega Menu block. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\system\Entity\Menu;
  use Drupal\block\Entity\Block;
  if (!Menu::load("we_mm_menu2")) {
    Menu::create(["id" => "we_mm_menu2", "label" => "WE MM Menu 2"])->save();
  }
  foreach (Block::loadMultiple() as $block) {
    if ($block->getPluginId() === "we_megamenu_block:we_mm_menu2") { $block->delete(); }
  }
  \Drupal::database()->delete("we_megamenu")->condition("menu_name", "we_mm_menu2")->execute();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: we_mm_menu2 exists, no we_megamenu_block:we_mm_menu2 placed"
