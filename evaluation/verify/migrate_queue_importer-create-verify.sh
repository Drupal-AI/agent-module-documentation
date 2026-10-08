#!/usr/bin/env bash
# Execution VERIFY: PASS when cron_migration mqi_task exists, is enabled, references migration
# 'mqi_target_migration', and has interval time=600. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $e = \Drupal::entityTypeManager()->getStorage("cron_migration")->load("mqi_task");
  if (!$e) { print "FAIL missing\n"; return; }
  $mig = $e->get("migration"); $time = (int) $e->get("time"); $status = (bool) $e->status();
  $ok = ($mig === "mqi_target_migration" && $time === 600 && $status);
  print ($ok ? "PASS" : "FAIL") . " migration=" . var_export($mig, TRUE) . " time=" . $time . " status=" . var_export($status, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
