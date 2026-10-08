#!/usr/bin/env bash
# Execution VERIFY: PASS when toc_filter on format toc_filter_hard2 has auto=top.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $auto = \Drupal::config("filter.format.toc_filter_hard2")->get("filters.toc_filter.settings.auto");
  $status = \Drupal::config("filter.format.toc_filter_hard2")->get("filters.toc_filter.status");
  $ok = ((bool) $status === TRUE && $auto === "top");
  print ($ok ? "PASS" : "FAIL") . " auto=" . var_export($auto, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
