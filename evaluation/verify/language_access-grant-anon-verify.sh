#!/usr/bin/env bash
# hard VERIFY (language_access): PASS when the anonymous role grants 'access language fy'.
# Reads live user.role.anonymous permissions. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $perms = \Drupal::config("user.role.anonymous")->get("permissions") ?: [];
  $ok = in_array("access language fy", $perms, TRUE);
  print ($ok ? "PASS" : "FAIL") . " anon_has_fy=" . ($ok ? "yes" : "no") . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
