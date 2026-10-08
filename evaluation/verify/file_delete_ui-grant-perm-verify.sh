#!/usr/bin/env bash
# Execution VERIFY: PASS when role file_delete_ui_deleter holds the 'delete any file'
# permission. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\user\Entity\Role;
  $r = Role::load("file_delete_ui_deleter");
  $ok = $r && $r->hasPermission("delete any file");
  print ($ok ? "PASS" : "FAIL") . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
