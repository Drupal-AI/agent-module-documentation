#!/usr/bin/env bash
# Execution RESET: ensure role menu_ppm_task exists and does NOT hold
# 'add new links to main menu from menu interface'. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\user\Entity\Role;
  $r = Role::load("menu_ppm_task") ?: Role::create(["id"=>"menu_ppm_task","label"=>"Menu PPM Task"]);
  $r->revokePermission("add new links to main menu from menu interface");
  $r->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: role menu_ppm_task present WITHOUT the add-links permission"
