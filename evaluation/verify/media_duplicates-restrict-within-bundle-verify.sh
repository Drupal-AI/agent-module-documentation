#!/usr/bin/env bash
# Execution VERIFY: PASS when restrict_duplicates===TRUE and compare_within_bundle_only===TRUE.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $c = \Drupal::config("media_duplicates.settings");
  $rd = $c->get("restrict_duplicates");
  $cb = $c->get("compare_within_bundle_only");
  $ok = ($rd === TRUE && $cb === TRUE);
  print ($ok ? "PASS" : "FAIL") . " restrict_duplicates=" . var_export($rd, TRUE) . " compare_within_bundle_only=" . var_export($cb, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
