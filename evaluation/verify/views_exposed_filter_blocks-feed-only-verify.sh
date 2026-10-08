#!/usr/bin/env bash
# Execution VERIFY for "place a filter block vefb_task2 for content:page_1 that only feeds the
# view (form_state_always_process OFF)". PASS when block.block.vefb_task2 exists with plugin
# views_exposed_filter_blocks_block, settings.view_display == "content:page_1", AND
# settings.form_state_always_process === FALSE. Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\block\Entity\Block;
  $b = Block::load("vefb_task2");
  $plugin = $b ? $b->get("plugin") : "none";
  $s = $b ? $b->get("settings") : [];
  $vd = $s["view_display"] ?? NULL;
  $fp = $s["form_state_always_process"] ?? NULL;
  $ok = ($b && $plugin === "views_exposed_filter_blocks_block" && $vd === "content:page_1" && $fp === FALSE);
  print ($ok ? "PASS" : "FAIL") . " plugin=" . $plugin . " view_display=" . var_export($vd, TRUE) . " form_state_always_process=" . var_export($fp, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
