#!/usr/bin/env bash
# Live-state verification for "create a block group `sidebar_promo` (label 'Sidebar Promo')".
# PASS (exit 0) when the block_group_content entity `sidebar_promo` exists AND it has added
# a theme region named `sidebar_promo` to the active theme (proving the group is live).
# Prints PASS/FAIL with detail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $ok = FALSE; $detail = "";
  $e = \Drupal::entityTypeManager()->getStorage("block_group_content")->load("sidebar_promo");
  if ($e) {
    $theme = \Drupal::theme()->getActiveTheme()->getName();
    $regions = system_region_list($theme);
    $region = isset($regions["sidebar_promo"]);
    $detail = " id=sidebar_promo label=\"" . $e->label() . "\" region=" . ($region ? 1 : 0);
    if ($e->label() !== "" && $e->label() !== NULL && $region) { $ok = TRUE; }
  }
  else { $detail = " (no block_group_content \"sidebar_promo\")"; }
  print ($ok ? "PASS" : "FAIL") . $detail . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
