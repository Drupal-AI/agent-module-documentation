#!/usr/bin/env bash
# event_log_track_stdout VERIFY-B: PASS when event_log_track_stdout.settings format contains 'ELT_CUSTOM'. Exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '$v=(string)\Drupal::config("event_log_track_stdout.settings")->get("format"); print ((strpos($v,"ELT_CUSTOM")!==FALSE)?"PASS":"FAIL")." format=".var_export($v,TRUE)."\n";' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
