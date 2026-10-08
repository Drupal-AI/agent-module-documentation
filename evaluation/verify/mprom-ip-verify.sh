#!/usr/bin/env bash
# Execution VERIFY: PASS when allowed_ips contains 10.9.8.7. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $ips = \Drupal::config("monitoring_prometheus.settings")->get("allowed_ips") ?? [];
  $ok = in_array("10.9.8.7", array_values($ips), TRUE);
  print ($ok ? "PASS" : "FAIL") . " allowed_ips=" . json_encode(array_values($ips)) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
