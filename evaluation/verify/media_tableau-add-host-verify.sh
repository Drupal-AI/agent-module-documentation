#!/usr/bin/env bash
# Execution VERIFY: PASS when media_tableau.settings:allowed_hosts contains
# https://mtb-task.example.com. Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $hosts = \Drupal::config("media_tableau.settings")->get("allowed_hosts") ?? [];
  $ok = in_array("https://mtb-task.example.com", $hosts, TRUE);
  print ($ok ? "PASS" : "FAIL") . " hosts=" . implode(",", $hosts) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
