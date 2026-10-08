#!/usr/bin/env bash
# Execution VERIFY: PASS when vtl_hard_view's default display uses the timelinejs style AND has a
# non-empty Start date field mapping. Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $v = \Drupal::config("views.view.vtl_hard_view");
  $type = $v->get("display.default.display_options.style.type");
  $sd = $v->get("display.default.display_options.style.options.timeline_fields.start_date");
  $ok = ($type === "timelinejs" && !empty($sd));
  print ($ok ? "PASS" : "FAIL") . " style=" . var_export($type, TRUE) . " start_date=" . var_export($sd, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
