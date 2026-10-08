#!/usr/bin/env bash
# Execution VERIFY: PASS when role sare_viewer exists and has the 'view site audit report'
# permission. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\user\Entity\Role;
  $r = Role::load("sare_viewer");
  $ok = $r && $r->hasPermission("view site audit report");
  print ($ok ? "PASS" : "FAIL") . " role=" . ($r ? "yes" : "no") . " perm=" . (($r && $r->hasPermission("view site audit report")) ? "yes" : "no") . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
