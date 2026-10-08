#!/usr/bin/env bash
# Execution RESET: create role csu_task WITHOUT the stock transaction form permission, so verify
# FAILS until the agent grants it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\user\Entity\Role;
  if ($r = Role::load("csu_task")) { $r->delete(); }
  Role::create(["id" => "csu_task", "label" => "CSU Task"])->save();
' >/dev/null 2>&1
echo "reset: role csu_task exists without the transaction-form permission"
