#!/usr/bin/env bash
# Execution VERIFY: PASS when role mie_role has permission 'metatag import export csv upload'. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\user\Entity\Role;
  $r = Role::load("mie_role");
  $ok = ($r && $r->hasPermission("metatag import export csv upload"));
  print ($ok ? "PASS" : "FAIL") . " role=" . ($r ? "yes" : "no") . " has_upload=" . (($r && $r->hasPermission("metatag import export csv upload")) ? "yes" : "no") . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
