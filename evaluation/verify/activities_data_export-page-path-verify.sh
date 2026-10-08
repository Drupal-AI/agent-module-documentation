#!/usr/bin/env bash
# Execution VERIFY: PASS when the activity_log 'page' display path is admin/reports/activity-log.
# exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $d = \Drupal::config("views.view.activity_log")->get("display");
  $p = $d["page"]["display_options"]["path"] ?? NULL;
  print (($p === "admin/reports/activity-log") ? "PASS" : "FAIL") . " path=" . var_export($p, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
