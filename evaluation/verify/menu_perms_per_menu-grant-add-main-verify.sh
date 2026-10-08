#!/usr/bin/env bash
# Execution VERIFY: PASS when role menu_ppm_task holds 'add new links to main menu from
# menu interface'. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\user\Entity\Role;
  $r = Role::load("menu_ppm_task");
  $ok = $r && $r->hasPermission("add new links to main menu from menu interface");
  print ($ok ? "PASS" : "FAIL") . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q "^PASS" && exit 0 || exit 1
