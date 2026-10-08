#!/usr/bin/env bash
# Execution VERIFY: PASS when the pp_reviewer role holds the paragraphs_previewer permission
# "view any paragraphs previewer". Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\user\Entity\Role;
  $role = Role::load("pp_reviewer");
  $ok = $role && $role->hasPermission("view any paragraphs previewer");
  print ($ok ? "PASS" : "FAIL") . " role=" . ($role ? "pp_reviewer" : "missing") .
    " perms=" . ($role ? implode("|", $role->getPermissions()) : "-") . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
