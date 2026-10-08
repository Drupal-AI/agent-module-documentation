#!/usr/bin/env bash
# Execution VERIFY: PASS when 198.51.100.42 is banned (present in ban_ip). exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $b = \Drupal::service("ban.ip_manager")->isBanned("198.51.100.42");
  print (($b ? "PASS" : "FAIL")) . " isBanned=" . var_export((bool) $b, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
