#!/usr/bin/env bash
# Execution VERIFY: PASS when role mie_role2 has permission 'metatag import export csv download'. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\user\Entity\Role;
  $r = Role::load("mie_role2");
  $ok = ($r && $r->hasPermission("metatag import export csv download"));
  print ($ok ? "PASS" : "FAIL") . " role=" . ($r ? "yes" : "no") . " has_download=" . (($r && $r->hasPermission("metatag import export csv download")) ? "yes" : "no") . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
