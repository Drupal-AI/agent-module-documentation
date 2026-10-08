#!/usr/bin/env bash
# Execution VERIFY: PASS when event_log_track.settings enables log deletion with timespan_limit=7.
# Exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $c = \Drupal::config("event_log_track.settings");
  $en = $c->get("enable_log_deletion"); $t = (int) $c->get("timespan_limit");
  $ok = ($en == TRUE && $t === 7);
  print ($ok ? "PASS" : "FAIL") . " enable_log_deletion=" . var_export($en,TRUE) . " timespan_limit=" . var_export($t,TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
