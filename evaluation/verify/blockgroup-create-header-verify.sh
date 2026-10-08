#!/usr/bin/env bash
# Live-state verification for "create a block group with id `header`".
# PASS (exit 0) when a block_group_content config entity `header` exists AND its derived
# block plugin `block_group:header` is registered. Prints PASS/FAIL with detail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $ok = FALSE; $detail = "";
  $e = \Drupal::entityTypeManager()->getStorage("block_group_content")->load("header");
  if ($e) {
    $defs = \Drupal::service("plugin.manager.block")->getDefinitions();
    $derived = isset($defs["block_group:header"]);
    $detail = " id=header label=\"" . $e->label() . "\" derived_block=" . ($derived ? 1 : 0);
    if ($e->label() !== "" && $e->label() !== NULL && $derived) { $ok = TRUE; }
  }
  else { $detail = " (no block_group_content \"header\")"; }
  print ($ok ? "PASS" : "FAIL") . $detail . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
