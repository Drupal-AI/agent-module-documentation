#!/usr/bin/env bash
# Execution VERIFY: PASS when cron cleanup keeps mail logs for 30 days.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $c = \Drupal::config("maillog.settings");
  $en = (bool) $c->get("cron_enabled");
  $type = $c->get("keep_limit_type");
  $days = (int) $c->get("time_to_keep");
  $ok = ($en === TRUE && $type === "time_to_keep" && $days === 30);
  print ($ok ? "PASS" : "FAIL") . " cron=" . var_export($en, TRUE) . " type=" . var_export($type, TRUE) . " days=$days\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
