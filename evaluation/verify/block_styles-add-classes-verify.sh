#!/usr/bin/env bash
# Execution VERIFY: PASS when block_styles 'bstyletaskb' classes contain 'bstyles-wide' AND theme is
# still block__clean. Exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $e = \Drupal::entityTypeManager()->getStorage("block_styles")->load("bstyletaskb");
  $theme = $e ? $e->get("theme") : "none";
  $classes = $e ? (string) $e->get("classes") : "";
  $ok = ($theme === "block__clean" && strpos($classes, "bstyles-wide") !== FALSE);
  print ($ok ? "PASS" : "FAIL") . " theme=" . $theme . " classes=" . $classes . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
