#!/usr/bin/env bash
# Execution VERIFY: PASS when role te_ui_role has the 'explore typed entity classes' permission.
# Prints PASS/FAIL. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\user\Entity\Role;
  $r = Role::load("te_ui_role");
  $ok = $r && $r->hasPermission("explore typed entity classes");
  print ($ok ? "PASS" : "FAIL") . " role=" . ($r ? "yes" : "no") . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
