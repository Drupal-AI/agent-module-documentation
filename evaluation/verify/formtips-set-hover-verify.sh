#!/usr/bin/env bash
# Execution VERIFY: PASS when formtips.settings:formtips_trigger_action === 'hover'.
# exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $v = \Drupal::config("formtips.settings")->get("formtips_trigger_action");
  print (($v === "hover") ? "PASS" : "FAIL") . " formtips_trigger_action=" . var_export($v, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
