#!/usr/bin/env bash
# Execution VERIFY: PASS when the queue_mail.language_negotiator service exists (submodule enabled).
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $has = \Drupal::hasService("queue_mail.language_negotiator");
  print ($has ? "PASS" : "FAIL") . " service=" . ($has ? "present" : "absent") . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
