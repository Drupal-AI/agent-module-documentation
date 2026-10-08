#!/usr/bin/env bash
# Execution VERIFY: PASS when cron_save_interval is set to 3600 (hourly). exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $v = \Drupal::config("site_audit_send.settings")->get("cron_save_interval");
  $ok = ((int) $v === 3600);
  print ($ok ? "PASS" : "FAIL") . " cron_save_interval=" . var_export($v, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
