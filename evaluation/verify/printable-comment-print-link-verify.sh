#!/usr/bin/env bash
# Execution VERIFY: PASS when 'comment' is among printable.settings.printable_print_link_locations.
# exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $v = \Drupal::config("printable.settings")->get("printable_print_link_locations");
  $v = is_array($v) ? $v : [];
  print (in_array("comment", $v, TRUE) ? "PASS" : "FAIL") . " locations=" . implode(",", $v) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
