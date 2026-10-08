#!/usr/bin/env bash
# Live-state verification for "let logged-in users see the events feed".
# PASS when the authenticated role holds the 'access events' permission. Exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $role = \Drupal\user\Entity\Role::load("authenticated");
  $ok = $role && $role->hasPermission("access events");
  print ($ok ? "PASS" : "FAIL") . " authenticated_has_access_events=" . ($ok ? 1 : 0) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
