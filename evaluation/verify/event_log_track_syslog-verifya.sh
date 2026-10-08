#!/usr/bin/env bash
# event_log_track_syslog VERIFY-A: PASS when event_log_track_syslog.settings output_type == 'syslog'. Exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '$v=\Drupal::config("event_log_track_syslog.settings")->get("output_type"); print (($v==="syslog")?"PASS":"FAIL")." output_type=".var_export($v,TRUE)."\n";' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
