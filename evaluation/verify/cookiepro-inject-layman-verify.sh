#!/usr/bin/env bash
# Execution VERIFY: PASS when cookiepro.header.settings.scripts contains the required
# data-domain-script id cp-task2-3344. Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $s = (string) \Drupal::config("cookiepro.header.settings")->get("scripts");
  $ok = (strpos($s, "cp-task2-3344") !== FALSE);
  print ($ok ? "PASS" : "FAIL") . " scripts_len=" . strlen($s) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
