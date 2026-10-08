#!/usr/bin/env bash
# Execution VERIFY: PASS when allowed_hosts is exactly ["https://only.mqtask.example.com"].
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $hosts = \Drupal::config("media_qualtrics.settings")->get("allowed_hosts") ?? [];
  $ok = ($hosts === ["https://only.mqtask.example.com"]);
  print ($ok ? "PASS" : "FAIL") . " hosts=" . implode(",", $hosts) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
