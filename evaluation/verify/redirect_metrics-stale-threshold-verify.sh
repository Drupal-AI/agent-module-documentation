#!/usr/bin/env bash
# Execution VERIFY: PASS when the redirect_metrics View page_2 last_access filter offset is
# '-3 months'. Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $cf = \Drupal::config("views.view.redirect_metrics");
  $val = $cf->get("display.page_2.display_options.filters.last_access.value");
  $offset = is_array($val) ? ($val["value"] ?? "") : "";
  $ok = (trim((string) $offset) === "-3 months");
  print ($ok ? "PASS" : "FAIL") . " offset=" . var_export($offset, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
