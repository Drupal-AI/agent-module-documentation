#!/usr/bin/env bash
# Execution VERIFY: PASS when role cecsv_team holds the 'access content export' permission. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\user\Entity\Role;
  $r = Role::load("cecsv_team");
  $ok = $r && $r->hasPermission("access content export");
  print ($ok ? "PASS" : "FAIL") . " role=" . ($r ? $r->id() : "none") . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
