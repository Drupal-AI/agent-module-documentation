#!/usr/bin/env bash
# Execution RESET: ensure role 'mnui_hard' exists WITHOUT 'send message through the ui'.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\user\Entity\Role;
  $r = Role::load("mnui_hard") ?: Role::create(["id"=>"mnui_hard","label"=>"MNUI Hard"]);
  $r->revokePermission("send message through the ui"); $r->save();
' >/dev/null 2>&1
echo "reset: role mnui_hard present without send perm"
