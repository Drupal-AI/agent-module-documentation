#!/usr/bin/env bash
# Live-state verification for the "grant content_editor the Image bulk-upload permission"
# task. Checks that the content_editor role holds the dynamic per-type permission
# `use media image bulk upload form`. Prints PASS/FAIL; exits 0 (pass) / 1 (fail).
set -uo pipefail
cd /var/www/html

out=$(drush php:eval '
  $role = \Drupal\user\Entity\Role::load("content_editor");
  $has = $role && $role->hasPermission("use media image bulk upload form");
  print ($has ? "PASS" : "FAIL") . " content_editor_has_perm=" . ($has?1:0) . "\n";
' 2>/dev/null)

echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
