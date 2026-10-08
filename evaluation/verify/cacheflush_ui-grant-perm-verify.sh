#!/usr/bin/env bash
# Execution VERIFY (cacheflush_ui): PASS when role cfu_grant_role has the 'cacheflush clear any'
# permission. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\user\Entity\Role;
  $r=Role::load("cfu_grant_role");
  print (($r && $r->hasPermission("cacheflush clear any"))?"PASS":"FAIL")."\n";
' 2>/dev/null)
echo "$out" | grep -q '^PASS' && { echo PASS; exit 0; }
echo FAIL; exit 1
