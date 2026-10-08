#!/usr/bin/env bash
# Execution VERIFY: PASS when custom_labels contains the value 'production'. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $labels = \Drupal::config("monitoring_prometheus.settings")->get("custom_labels") ?? [];
  $ok = in_array("production", array_values($labels), TRUE);
  print ($ok ? "PASS" : "FAIL") . " custom_labels=" . json_encode($labels) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
