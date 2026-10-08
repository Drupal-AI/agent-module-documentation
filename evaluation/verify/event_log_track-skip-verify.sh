#!/usr/bin/env bash
# Execution VERIFY: PASS when event_log_track.settings skip_patterns contains a 'system.*' line.
# Exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $p = (string) \Drupal::config("event_log_track.settings")->get("skip_patterns");
  $lines = array_map("trim", explode("\n", $p));
  $ok = in_array("system.*", $lines, TRUE);
  print ($ok ? "PASS" : "FAIL") . " skip_patterns=" . var_export($p,TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
