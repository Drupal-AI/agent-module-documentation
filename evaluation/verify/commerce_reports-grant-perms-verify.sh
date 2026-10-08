#!/usr/bin/env bash
# Execution VERIFY: PASS when role creports_analyst has BOTH commerce_reports permissions.
# exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $r = \Drupal\user\Entity\Role::load("creports_analyst");
  $ok = $r && $r->hasPermission("access commerce reports") && $r->hasPermission("generate commerce order reports");
  print $ok ? "PASS" : "FAIL";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
