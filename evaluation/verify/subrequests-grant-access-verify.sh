#!/usr/bin/env bash
# Execution VERIFY for "grant issue subrequests to subreq_client_role".
# PASS when the role exists and carries the 'issue subrequests' permission.
# Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $role = \Drupal::entityTypeManager()->getStorage("user_role")->load("subreq_client_role");
  $has = $role ? $role->hasPermission("issue subrequests") : FALSE;
  $ok = $role && $has;
  print ($ok ? "PASS" : "FAIL") . " role_exists=" . ($role ? "yes" : "no") . " issue_subrequests=" . var_export($has, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
