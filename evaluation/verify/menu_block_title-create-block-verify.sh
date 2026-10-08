#!/usr/bin/env bash
# Execution VERIFY: PASS when block.block.mbt_built exists, is a menu block (system_menu_block:* or a
# menu_block derivative), has label_display visible, and modify_title === TRUE. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\block\Entity\Block;
  $b = Block::load("mbt_built");
  $ok = FALSE; $plugin = "none"; $ld = "none"; $mt = NULL;
  if ($b) {
    $plugin = $b->getPluginId();
    $ld = $b->get("settings")["label_display"] ?? "none";
    $mt = $b->getThirdPartySetting("menu_block_title", "modify_title");
    $is_menu = (strpos($plugin, "system_menu_block:") === 0) || (strpos($plugin, "menu_block:") === 0);
    $ok = $is_menu && ($ld === "visible" || $ld === TRUE) && ($mt === TRUE || $mt === 1 || $mt === "1");
  }
  print ($ok ? "PASS" : "FAIL") . " plugin=" . $plugin . " label_display=" . var_export($ld, TRUE) . " modify_title=" . var_export($mt, TRUE) . "\n";
' 2>/dev/null)
echo "$out"; echo "$out" | grep -q '^PASS' && exit 0 || exit 1
