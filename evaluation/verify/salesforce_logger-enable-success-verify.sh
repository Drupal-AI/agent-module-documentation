#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $v = \Drupal::config("salesforce_logger.settings")->get("log_push_success");
  print (($v === TRUE) ? "PASS" : "FAIL") . " log_push_success=" . var_export($v, TRUE) . "\n";
' 2>/dev/null)
echo "$out"; echo "$out" | grep -q '^PASS' && exit 0 || exit 1
