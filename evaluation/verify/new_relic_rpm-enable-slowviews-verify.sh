#!/usr/bin/env bash
# Execution VERIFY: PASS when new_relic_rpm.settings has views_log_slow===TRUE and
# views_log_threshold===500. Prints PASS/FAIL. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $c = \Drupal::config("new_relic_rpm.settings");
  $slow = $c->get("views_log_slow");
  $thr = $c->get("views_log_threshold");
  $ok = ($slow === TRUE && (int) $thr === 500);
  print ($ok ? "PASS" : "FAIL") . " views_log_slow=" . var_export($slow, TRUE) . " views_log_threshold=" . var_export($thr, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
