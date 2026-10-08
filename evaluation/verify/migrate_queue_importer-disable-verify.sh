#!/usr/bin/env bash
# Execution VERIFY: PASS when cron_migration mqi_toggle exists but is DISABLED (status FALSE).
# exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $e = \Drupal::entityTypeManager()->getStorage("cron_migration")->load("mqi_toggle");
  if (!$e) { print "FAIL missing\n"; return; }
  $status = (bool) $e->status();
  print ($status ? "FAIL" : "PASS") . " status=" . var_export($status, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
