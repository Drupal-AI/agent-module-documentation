#!/usr/bin/env bash
# Execution VERIFY: PASS when block_styles 'bsboot_task' has theme==block__bootstrap__modal and
# text=='Open'. Exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $e = \Drupal::entityTypeManager()->getStorage("block_styles")->load("bsboot_task");
  $theme = $e ? $e->get("theme") : "none";
  $text = $e ? (string) $e->get("text") : "";
  $ok = ($theme === "block__bootstrap__modal" && $text === "Open");
  print ($ok ? "PASS" : "FAIL") . " theme=" . $theme . " text=" . $text . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
