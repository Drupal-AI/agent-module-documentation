#!/usr/bin/env bash
# Execution RESET: ensure role menu_ppm_task2 exists and lacks 'enable/disable links in
# footer menu'. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\user\Entity\Role;
  $r = Role::load("menu_ppm_task2") ?: Role::create(["id"=>"menu_ppm_task2","label"=>"Menu PPM Task 2"]);
  $r->revokePermission("enable/disable links in footer menu");
  $r->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: role menu_ppm_task2 present WITHOUT enable/disable footer permission"
