#!/usr/bin/env bash
# Execution VERIFY: PASS when the ajax_quiz_role role holds the 'access ajax quiz' permission.
# Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\user\Entity\Role;
  $r = Role::load("ajax_quiz_role");
  $ok = ($r && $r->hasPermission("access ajax quiz"));
  print ($ok ? "PASS" : "FAIL") . " role=" . ($r?"1":"0") . " has_perm=" . ($r && $r->hasPermission("access ajax quiz") ? "1" : "0") . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
