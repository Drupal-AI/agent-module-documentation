#!/usr/bin/env bash
# Execution VERIFY: PASS when restrict_duplicates===TRUE and restrict_new_media_only===TRUE.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $c = \Drupal::config("media_duplicates.settings");
  $rd = $c->get("restrict_duplicates");
  $rn = $c->get("restrict_new_media_only");
  $ok = ($rd === TRUE && $rn === TRUE);
  print ($ok ? "PASS" : "FAIL") . " restrict_duplicates=" . var_export($rd, TRUE) . " restrict_new_media_only=" . var_export($rn, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
