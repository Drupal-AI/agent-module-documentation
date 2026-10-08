#!/usr/bin/env bash
# hard VERIFY (language_access): PASS when role langaccess_task grants 'access language fo'.
# Reads the live user.role.langaccess_task permissions (what Role::save() persists). exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $perms = \Drupal::config("user.role.langaccess_task")->get("permissions") ?: [];
  $ok = in_array("access language fo", $perms, TRUE);
  print ($ok ? "PASS" : "FAIL") . " perms=" . json_encode($perms) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
