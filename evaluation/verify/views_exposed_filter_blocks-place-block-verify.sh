#!/usr/bin/env bash
# Execution VERIFY for "place a Views exposed filter block vefb_task for content:page_1".
# PASS when block.block.vefb_task exists, uses plugin views_exposed_filter_blocks_block, and
# its settings.view_display == "content:page_1". Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\block\Entity\Block;
  $b = Block::load("vefb_task");
  $plugin = $b ? $b->get("plugin") : "none";
  $vd = $b ? ($b->get("settings")["view_display"] ?? NULL) : NULL;
  $ok = ($b && $plugin === "views_exposed_filter_blocks_block" && $vd === "content:page_1");
  print ($ok ? "PASS" : "FAIL") . " plugin=" . $plugin . " view_display=" . var_export($vd, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
