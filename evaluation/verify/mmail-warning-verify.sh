#!/usr/bin/env bash
# Execution VERIFY: PASS when severities includes WARNING. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $sev = \Drupal::config("monitoring_mail.settings")->get("severities") ?? [];
  $ok = in_array("WARNING", array_values($sev), TRUE);
  print ($ok ? "PASS" : "FAIL") . " severities=" . json_encode(array_values($sev)) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
