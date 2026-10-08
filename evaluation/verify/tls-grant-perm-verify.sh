#!/usr/bin/env bash
# Execution VERIFY: PASS when role tls_task_role has the 'use toolbar_language_switcher' permission.
# Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\user\Entity\Role;
  $r = Role::load("tls_task_role");
  $ok = $r && $r->hasPermission("use toolbar_language_switcher");
  print ($ok ? "PASS" : "FAIL") . " tls_task_role has_perm=" . ($ok ? "yes" : "no") . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
