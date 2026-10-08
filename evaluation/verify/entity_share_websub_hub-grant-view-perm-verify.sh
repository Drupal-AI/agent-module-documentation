#!/usr/bin/env bash
# Execution VERIFY: PASS when role eswhub_editor has 'see content subscriptions'. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $r = \Drupal\user\Entity\Role::load("eswhub_editor");
  print ($r && $r->hasPermission("see content subscriptions")) ? "PASS" : "FAIL";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
