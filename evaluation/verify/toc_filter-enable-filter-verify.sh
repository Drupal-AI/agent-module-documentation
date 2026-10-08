#!/usr/bin/env bash
# Execution VERIFY: PASS when the toc_filter filter is enabled on format toc_filter_hard.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $status = \Drupal::config("filter.format.toc_filter_hard")->get("filters.toc_filter.status");
  $ok = ((bool) $status === TRUE);
  print ($ok ? "PASS" : "FAIL") . " status=" . var_export($status, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
