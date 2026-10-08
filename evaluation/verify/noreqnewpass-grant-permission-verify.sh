#!/usr/bin/env bash
# Live-state verification for the "grant content_editor the administer noreqnewpass
# permission" task. Checks the content_editor role holds `administer noreqnewpass`.
# Prints PASS/FAIL; exits 0 (pass) / 1 (fail). No arguments.
set -uo pipefail
cd /var/www/html

out=$(drush php:eval '
  $role = \Drupal\user\Entity\Role::load("content_editor");
  $has = $role && $role->hasPermission("administer noreqnewpass");
  print ($has ? "PASS" : "FAIL") . " content_editor_has_perm=" . ($has?1:0) . "\n";
' 2>/dev/null)

echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
