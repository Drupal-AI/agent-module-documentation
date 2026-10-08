#!/usr/bin/env bash
# Execution VERIFY: PASS when role menu_ppm_task2 holds 'enable/disable links in footer menu'.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\user\Entity\Role;
  $r = Role::load("menu_ppm_task2");
  $ok = $r && $r->hasPermission("enable/disable links in footer menu");
  print ($ok ? "PASS" : "FAIL") . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q "^PASS" && exit 0 || exit 1
