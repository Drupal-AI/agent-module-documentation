#!/usr/bin/env bash
# Execution VERIFY: PASS when field_drt_disp's daterange_timezone formatter on the default view
# display has display_timezone === FALSE (timezone label hidden). exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $comp = \Drupal::service("entity_display.repository")->getViewDisplay("node","article")->getComponent("field_drt_disp");
  $type = $comp["type"] ?? "none";
  $dt = $comp["settings"]["display_timezone"] ?? NULL;
  $ok = ($type === "daterange_timezone") && ($dt === FALSE || $dt === 0 || $dt === "0");
  print ($ok ? "PASS" : "FAIL") . " formatter=" . $type . " display_timezone=" . var_export($dt, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
