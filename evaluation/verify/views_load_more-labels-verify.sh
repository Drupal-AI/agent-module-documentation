#!/usr/bin/env bash
# Execution VERIFY: PASS when vlm_labels' load_more pager has more_button_text
# 'Load older articles' AND end_text 'That is everything'. Pure config read. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $p = \Drupal::config("views.view.vlm_labels")->get("display.default.display_options.pager");
  $type = $p["type"] ?? NULL;
  $btn = $p["options"]["more_button_text"] ?? NULL;
  $end = $p["options"]["end_text"] ?? NULL;
  $ok = ($type === "load_more" && $btn === "Load older articles" && $end === "That is everything");
  print (($ok) ? "PASS" : "FAIL") . " type=" . var_export($type, TRUE) . " btn=" . var_export($btn, TRUE) . " end=" . var_export($end, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
