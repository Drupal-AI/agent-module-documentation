#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $v = \Drupal::config("salesforce_logger.settings")->get("log_level");
  print (($v === "salesforce.notice") ? "PASS" : "FAIL") . " log_level=" . var_export($v, TRUE) . "\n";
' 2>/dev/null)
echo "$out"; echo "$out" | grep -q '^PASS' && exit 0 || exit 1
