#!/usr/bin/env bash
# Execution RESET: ensure a namespaced role tp_task exists WITHOUT any per-theme permission, so
# verify FAILS until the agent grants 'administer themes claro'. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\user\Entity\Role;
  if ($r = Role::load("tp_task")) { $r->delete(); }
  Role::create(["id" => "tp_task", "label" => "TP Task"])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: role tp_task present with no per-theme permission"
