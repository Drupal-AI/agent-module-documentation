#!/usr/bin/env bash
# Live-state verification for the "place a lang_dropdown block `eval_ld_simple` using the
# Simple HTML select output type, Language Code display, width 220" execution task.
# Prints PASS/FAIL with detail and exits 0 (pass) / 1 (fail). PASS only if the block
# config entity `eval_ld_simple` exists AND uses a language_dropdown_block plugin AND has
# settings widget=0 (Simple HTML select) AND display=2 (language code) AND width=220.
set -uo pipefail
cd /var/www/html

out=$(drush php:eval '
  $b = \Drupal::entityTypeManager()->getStorage("block")->load("eval_ld_simple");
  $exists = (bool) $b;
  $plugin = $exists ? (string) $b->getPluginId() : "";
  $is_ld = strpos($plugin, "language_dropdown_block") === 0;
  $s = $exists ? (array) $b->get("settings") : [];
  $widget  = array_key_exists("widget", $s)  ? (int) $s["widget"]  : -1;
  $display = array_key_exists("display", $s) ? (int) $s["display"] : -1;
  $width   = array_key_exists("width", $s)   ? (int) $s["width"]   : -1;
  $ok = $exists && $is_ld && $widget === 0 && $display === 2 && $width === 220;
  print ($ok ? "PASS" : "FAIL")
    . " exists=" . ($exists ? 1 : 0)
    . " plugin=" . ($plugin === "" ? "-" : $plugin)
    . " widget=" . $widget
    . " display=" . $display
    . " width=" . $width . "\n";
' 2>/dev/null)

echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
