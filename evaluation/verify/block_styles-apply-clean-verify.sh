#!/usr/bin/env bash
# Execution VERIFY: PASS when block_styles entity 'bstyletask' has theme==block__clean and classes
# containing 'bstyles-featured'. Exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $e = \Drupal::entityTypeManager()->getStorage("block_styles")->load("bstyletask");
  $theme = $e ? $e->get("theme") : "none";
  $classes = $e ? (string) $e->get("classes") : "";
  $ok = ($theme === "block__clean" && strpos($classes, "bstyles-featured") !== FALSE);
  print ($ok ? "PASS" : "FAIL") . " theme=" . $theme . " classes=" . $classes . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
