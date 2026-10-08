#!/usr/bin/env bash
# Execution VERIFY: PASS when role dubbot_reviewer has BOTH 'access dubbot report' and
# 'view dubbot accessibility tab'. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\user\Entity\Role;
  $r = Role::load("dubbot_reviewer");
  $ok = $r && $r->hasPermission("access dubbot report") && $r->hasPermission("view dubbot accessibility tab");
  print ($ok ? "PASS" : "FAIL") . " report=" . var_export($r && $r->hasPermission("access dubbot report"), TRUE) . " a11y=" . var_export($r && $r->hasPermission("view dubbot accessibility tab"), TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q "^PASS" && exit 0 || exit 1
