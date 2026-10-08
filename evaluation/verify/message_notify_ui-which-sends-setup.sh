#!/usr/bin/env bash
# Introspection SETUP: create two roles, mnui_yes (WITH the send perm) and mnui_no (WITHOUT).
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\user\Entity\Role;
  $y = Role::load("mnui_yes") ?: Role::create(["id"=>"mnui_yes","label"=>"MNUI Yes"]);
  $y->grantPermission("send message through the ui"); $y->save();
  $n = Role::load("mnui_no") ?: Role::create(["id"=>"mnui_no","label"=>"MNUI No"]);
  $n->revokePermission("send message through the ui"); $n->save();
' >/dev/null 2>&1
echo "setup: mnui_yes can send, mnui_no cannot"
