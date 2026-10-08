#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\user\Entity\Role;
  \Drupal::keyValueExpirable("filter_perms_list")->delete("1");
  if ($r = Role::load("fperm_reviewer")) { $r->delete(); }
' >/dev/null 2>&1
echo "cleanup: fperm_reviewer role and filter_perms_list[1] removed"
