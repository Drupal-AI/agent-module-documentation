#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $v = \Drupal::config("salesforce.settings")->get("pull_max_queue_size");
  print (($v === 1000) ? "PASS" : "FAIL") . " pull_max_queue_size=" . var_export($v, TRUE) . "\n";
' 2>/dev/null)
echo "$out"; echo "$out" | grep -q '^PASS' && exit 0 || exit 1
