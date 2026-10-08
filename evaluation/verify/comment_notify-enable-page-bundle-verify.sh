#!/usr/bin/env bash
# Execution VERIFY: PASS when comment_notify.settings:bundle_types contains node--page--comment.
# Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $bt = \Drupal::config("comment_notify.settings")->get("bundle_types") ?: [];
  $ok = in_array("node--page--comment", $bt, TRUE);
  print ($ok ? "PASS" : "FAIL") . " bundle_types=" . implode(",", $bt) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
