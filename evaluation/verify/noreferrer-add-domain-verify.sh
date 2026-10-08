#!/usr/bin/env bash
# Execution VERIFY: PASS when trusted-partner.example is in the allowed-domains list.
# Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $d = \Drupal::config("noreferrer.settings")->get("allowed_domains");
  $d = is_array($d) ? $d : [];
  $ok = in_array("trusted-partner.example", $d, TRUE);
  print ($ok ? "PASS" : "FAIL") . " allowed_domains=" . implode(",", $d) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
