#!/usr/bin/env bash
# Execution VERIFY: PASS when the global link-alter flag is ON
# (noopener_filter.settings:filter_links === 1). Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $v = \Drupal::config("noopener_filter.settings")->get("filter_links");
  $ok = ((int) $v === 1);
  print ($ok ? "PASS" : "FAIL") . " filter_links=" . var_export($v, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
