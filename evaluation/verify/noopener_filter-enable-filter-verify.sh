#!/usr/bin/env bash
# Execution VERIFY: PASS when the noopener filter (filter_noopener) is enabled on the
# noopener_hard_fmt text format. Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $status = \Drupal::config("filter.format.noopener_hard_fmt")->get("filters.filter_noopener.status");
  $ok = ($status == TRUE);
  print ($ok ? "PASS" : "FAIL") . " filter_noopener.status=" . var_export($status, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
