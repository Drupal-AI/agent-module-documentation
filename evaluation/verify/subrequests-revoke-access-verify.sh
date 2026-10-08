#!/usr/bin/env bash
# Execution VERIFY for "revoke issue subrequests from subreq_legacy_role, keep access
# content". PASS when the role exists, no longer has 'issue subrequests', but still has
# 'access content' (proves the agent revoked the one permission, not the whole role).
# Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $role = \Drupal::entityTypeManager()->getStorage("user_role")->load("subreq_legacy_role");
  $has_issue = $role ? $role->hasPermission("issue subrequests") : NULL;
  $has_access = $role ? $role->hasPermission("access content") : NULL;
  $ok = $role && !$has_issue && $has_access;
  print ($ok ? "PASS" : "FAIL") . " role_exists=" . ($role ? "yes" : "no") . " issue_subrequests=" . var_export($has_issue, TRUE) . " access_content=" . var_export($has_access, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
