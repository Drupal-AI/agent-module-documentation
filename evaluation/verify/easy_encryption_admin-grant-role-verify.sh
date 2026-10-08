#!/usr/bin/env bash
# Execution VERIFY: PASS when role eea_keymanager exists and has 'administer easy encryption keys'.
# Exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\user\Entity\Role;
  $r = Role::load("eea_keymanager");
  if (!$r) { print "FAIL no-role\n"; return; }
  print ($r->hasPermission("administer easy encryption keys") ? "PASS" : "FAIL") . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
