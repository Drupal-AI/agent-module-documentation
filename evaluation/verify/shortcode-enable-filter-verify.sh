#!/usr/bin/env bash
# Execution VERIFY for "enable the shortcode filter on shortcode_task". PASS when
# filter.format.shortcode_task filters.shortcode.status === TRUE. Prints PASS/FAIL; exit 0
# pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $status = \Drupal::config("filter.format.shortcode_task")->get("filters.shortcode.status");
  $ok = ($status === TRUE);
  print ($ok ? "PASS" : "FAIL") . " status=" . var_export($status, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
