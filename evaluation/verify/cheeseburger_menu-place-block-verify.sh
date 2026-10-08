#!/usr/bin/env bash
# Execution VERIFY: PASS when a block config entity "cbm_task" exists whose plugin is
# "cheeseburger_menu" and which aggregates at least one menu/vocabulary in its settings.menus.
# Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\block\Entity\Block;
  $b = Block::load("cbm_task");
  $plugin = $b ? $b->getPluginId() : "none";
  $menus = $b ? ($b->get("settings")["menus"] ?? []) : [];
  $ok = ($b !== NULL && $plugin === "cheeseburger_menu" && is_array($menus) && count($menus) > 0);
  print ($ok ? "PASS" : "FAIL") . " plugin=" . $plugin . " menus=" . count($menus) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
