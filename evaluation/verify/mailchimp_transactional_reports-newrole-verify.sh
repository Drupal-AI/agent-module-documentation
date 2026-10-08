#!/usr/bin/env bash
# Execution VERIFY: PASS when a role 'mtr_new' exists AND has 'view mailchimp transactional
# reports'. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\user\Entity\Role;
  $r = Role::load("mtr_new");
  $ok = ($r && $r->hasPermission("view mailchimp transactional reports"));
  print ($ok ? "PASS" : "FAIL") . " exists=" . var_export((bool)$r, TRUE) . " has_perm=" . var_export($r ? $r->hasPermission("view mailchimp transactional reports") : NULL, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
