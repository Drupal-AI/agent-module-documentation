#!/usr/bin/env bash
# Execution VERIFY: PASS when node.article field_sf_txt uses the swiper_formatter_text
# formatter in the default view display. Prints PASS/FAIL; exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $disp = \Drupal::config("core.entity_view_display.node.article.default");
  $type = $disp->get("content.field_sf_txt.type");
  $ok = ($type === "swiper_formatter_text");
  print ($ok ? "PASS" : "FAIL") . " type=" . var_export($type, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
