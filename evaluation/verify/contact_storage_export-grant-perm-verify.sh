#!/usr/bin/env bash
# Execution VERIFY: PASS when the authenticated role has 'export contact form messages'.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $r = \Drupal\user\Entity\Role::load("authenticated");
  $ok = $r && $r->hasPermission("export contact form messages");
  print ($ok ? "PASS" : "FAIL") . " has_perm=" . var_export((bool) $ok, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
