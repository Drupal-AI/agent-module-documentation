#!/usr/bin/env bash
# Execution VERIFY: PASS when role mtr_task has the 'view mailchimp transactional reports'
# permission. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\user\Entity\Role;
  $r = Role::load("mtr_task");
  $has = $r ? $r->hasPermission("view mailchimp transactional reports") : FALSE;
  print ($has ? "PASS" : "FAIL") . " mtr_task_has_perm=" . var_export($has, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
