#!/usr/bin/env bash
# Execution VERIFY: PASS when role bpp_multi holds BOTH 'access site reports' and
# 'view the administration theme'. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\user\Entity\Role;
  $r = Role::load("bpp_multi");
  $p = $r ? $r->getPermissions() : [];
  $ok = in_array("access site reports", $p, TRUE) && in_array("view the administration theme", $p, TRUE);
  print ($ok ? "PASS" : "FAIL") . " perms=" . implode("|", $p) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
