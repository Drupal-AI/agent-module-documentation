#!/usr/bin/env bash
# PASS when 192.0.2.99 is NOT banned (the agent removed the ban).
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $b=\Drupal::service("ban.ip_manager")->isBanned("192.0.2.99");
  print ((!$b)?"PASS":"FAIL")." isBanned=".var_export((bool)$b,TRUE)."\n";
' 2>/dev/null)
echo "$out"; echo "$out" | grep -q '^PASS' && exit 0 || exit 1
