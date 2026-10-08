#!/usr/bin/env bash
# Execution CLEANUP: delete any we_megamenu_block:we_mm_menu2 blocks, the megamenu rows, and the
# we_mm_menu2 menu.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\system\Entity\Menu;
  use Drupal\block\Entity\Block;
  foreach (Block::loadMultiple() as $block) {
    if ($block->getPluginId() === "we_megamenu_block:we_mm_menu2") { $block->delete(); }
  }
  \Drupal::database()->delete("we_megamenu")->condition("menu_name", "we_mm_menu2")->execute();
  if ($m = Menu::load("we_mm_menu2")) { $m->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: removed we_mm_menu2, its blocks and megamenu rows"
