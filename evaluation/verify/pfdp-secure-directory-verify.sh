#!/usr/bin/env bash
# Execution VERIFY for "register the private directory /pfdp-secure for pfdp_task_role and
# allow the uploader of a file to download it".
# PASS when a pfdp_directory config entity with id pfdp_task_dir exists with path '/pfdp-secure',
# bypass FALSE, grant_file_owners TRUE and 'pfdp_task_role' in its roles list.
# Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $d = \Drupal\pfdp\Entity\DirectoryEntity::load("pfdp_task_dir");
  if (!$d) { print "FAIL directory=missing\n"; return; }
  $roles = array_values((array) $d->roles);
  $ok = ($d->path === "/pfdp-secure")
    && !$d->bypass
    && (bool) $d->grant_file_owners
    && in_array("pfdp_task_role", $roles, TRUE);
  print ($ok ? "PASS" : "FAIL")
    . " path=" . var_export($d->path, TRUE)
    . " bypass=" . var_export((bool) $d->bypass, TRUE)
    . " grant_file_owners=" . var_export((bool) $d->grant_file_owners, TRUE)
    . " roles=" . implode(",", $roles) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
